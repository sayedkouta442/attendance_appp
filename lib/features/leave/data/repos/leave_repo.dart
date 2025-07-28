import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/features/leave/data/apis/leave_remote_data_source.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:dartz/dartz.dart';

abstract class LeaveRepo {
  Future<Either<Failure, void>> leaveRequest(LeaveModel leave);
}

class LeaveRepoImpl extends LeaveRepo {
  final LeaveRemoteDataSource leaveRemoteDateSource;

  LeaveRepoImpl(this.leaveRemoteDateSource);
  @override
  Future<Either<Failure, void>> leaveRequest(LeaveModel leave) async {
    try {
      var result = await leaveRemoteDateSource.leaveRequest(leave);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
