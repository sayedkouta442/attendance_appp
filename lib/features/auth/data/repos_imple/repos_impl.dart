import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  });
}

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
  }
}
