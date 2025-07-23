import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/features/record_attendance/data/data_sources/attendance_remote_data_source.dart';
import 'package:attendance_appp/features/record_attendance/data/models/record_attendance.dart';
import 'package:dartz/dartz.dart';

abstract class RecordAttendanceRepo {
  Future<Either<Failure, void>> recordAttendance(AttendanceRecordModel record);
  Future<Either<Failure, void>> updateAttendance(AttendanceRecordModel record);
}

class RecordAttendanceRepoImpl implements RecordAttendanceRepo {
  final RecordAttendanceRemoteDataSource remoteDataSource;

  RecordAttendanceRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> recordAttendance(
    AttendanceRecordModel record,
  ) async {
    try {
      await remoteDataSource.recordAttendance(record);
      // ignore: void_checks
      return right(unit);
    } catch (e) {
      return left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateAttendance(
    AttendanceRecordModel record,
  ) async {
    try {
      await remoteDataSource.updateAttendance(record);
      // ignore: void_checks
      return right(unit);
    } catch (e) {
      return left(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    if (e is Failure) return e;
    return ServerFailure(e.toString());
  }
}
