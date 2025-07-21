import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on AuthException catch (e) {
      return Left(ServerFailure.fromAuthException(e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred.'));
    }
  }
}
