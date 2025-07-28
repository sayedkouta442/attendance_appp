import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/features/atten_history/data/models/attendance_history_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AttendanceHistoryRemoteDataSource {
  Future<List<AttendanceRecord>> fetchAttendanceRecords({int month, int year});
}

class AttendanceHistoryRemoteDataSourceImpl
    extends AttendanceHistoryRemoteDataSource {
  @override
  Future<List<AttendanceRecord>> fetchAttendanceRecords({
    int? month,
    int? year,
  }) async {
    try {
      // ابدأ بالاستعلام الأساسي بدون ترتيب
      var query = client
          .from('attendance_records')
          .select(
            'employee_id, record_date, check_in_time, check_out_time, status, working_hours',
          )
          .eq('employee_id', userId);

      if (year != null) {
        DateTime startDate;
        DateTime endDate;

        if (month != null) {
          // Filter by specific month and year
          startDate = DateTime(year, month, 1);
          endDate = DateTime(
            year,
            month + 1,
            1,
          ).subtract(const Duration(days: 1));
        } else {
          // Filter by year only
          startDate = DateTime(year, 1, 1);
          endDate = DateTime(year + 1, 1, 1).subtract(const Duration(days: 1));
        }

        query = query
            .gte('record_date', startDate.toIso8601String().split('T').first)
            .lte('record_date', endDate.toIso8601String().split('T').first);
        // --- نهاية التصحيح ---
      }

      final response = await query.order('record_date', ascending: false);

      // قم بتحويل الاستجابة إلى قائمة من كائنات AttendanceRecord
      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        response,
      );
      return data.map((json) => AttendanceRecord.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      // Handle Supabase specific errors
      print('Supabase PostgrestException: ${e.message}');
      throw Exception('Failed to fetch attendance records: ${e.message}');
    } catch (e) {
      // Handle other potential errors
      print('Error fetching attendance records: $e');
      throw Exception('Failed to fetch attendance records: $e');
    }
  }

  // Additional method to fetch records for current month
  Future<List<AttendanceRecord>> fetchCurrentMonthRecords() async {
    final now = DateTime.now();
    return fetchAttendanceRecords(month: now.month, year: now.year);
  }

  // Additional method to fetch records for current year
  Future<List<AttendanceRecord>> fetchCurrentYearRecords() async {
    final now = DateTime.now();
    return fetchAttendanceRecords(year: now.year);
  }
}
