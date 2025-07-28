import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/features/user/data/apis/user_remote_data_source.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:attendance_appp/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failure, UserModel>> fetchUserData();
}

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepoImpl(this._userRemoteDataSource);
  @override
  Future<Either<Failure, UserModel>> fetchUserData() async {
    try {
      var result = await _userRemoteDataSource.fetchUserData();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
