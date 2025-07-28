import 'package:attendance_appp/core/errors/failures.dart';
import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/features/record_attendance/data/models/record_attendance.dart';

abstract class RecordAttendanceRemoteDataSource {
  Future<void> recordAttendance(AttendanceRecordModel record);
  Future<void> updateAttendance(AttendanceRecordModel record);

  Future<String?> fetchUserImageUrl();
}

class RecordAttendanceRemoteDataSourceImpl
    implements RecordAttendanceRemoteDataSource {
  @override
  Future<void> recordAttendance(AttendanceRecordModel record) async {
    try {
      final response = await client
          .from('attendance_records')
          .insert(record.toInsertJson());

      print('insertedRemoteEEEEEEEEEEEEEEE');
      if (response.error != null) {
        throw Exception(
          'Failed to record attendance: ${response.error!.message}',
        );
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> updateAttendance(AttendanceRecordModel record) async {
    try {
      final todayDate = DateTime.now().toIso8601String().split("T")[0];

      final response = await client
          .from('attendance_records')
          .update(record.toUpdateJson())
          .eq('employee_id', record.employeeId)
          .eq('record_date', todayDate)
          .isFilter('check_out_time', null);

      // Add detailed debugging
      print('🔥 Supa update response: $response');

      if (response == null || (response is List && response.isEmpty)) {
        throw Exception('No matching attendance record found to update.');
      }
    } catch (e, st) {
      print('🛑 updateAttendance exception: $e\n$st');
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<String?> fetchUserImageUrl() async {
    try {
      final response = await client
          .from('face_recognition_data')
          .select('face_image_url')
          .eq('employee_id', userId)
          .maybeSingle();
      print(
        'Supabase response************************************************************************: $response',
      );
      return response?['face_image_url'] as String?;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
