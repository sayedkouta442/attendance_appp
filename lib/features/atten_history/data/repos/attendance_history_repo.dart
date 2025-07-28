import 'package:attendance_appp/features/atten_history/data/data_sources/attendance_history_remote_data_source.dart';
import 'package:attendance_appp/features/atten_history/data/models/attendance_history_model.dart';

abstract class AttendanceHistoryRepo {
  Future<List<AttendanceRecord>> fetchAttendanceRecords(int month, int year);
}

class AttendanceHistoryRepoImpl extends AttendanceHistoryRepo {
  final AttendanceHistoryRemoteDataSource attendanceHistoryRemoteDataSource;

  AttendanceHistoryRepoImpl(this.attendanceHistoryRemoteDataSource);
  @override
  Future<List<AttendanceRecord>> fetchAttendanceRecords(int month, int year) {
    return attendanceHistoryRemoteDataSource.fetchAttendanceRecords(
      month: month,
      year: year,
    );
  }
}
