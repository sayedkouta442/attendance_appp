import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:attendance_appp/features/atten_history/data/models/attendance_history_model.dart'; // تأكد من استيراد النموذج
import 'package:attendance_appp/features/atten_history/data/repos/attendance_history_repo.dart'; // تأكد من استيراد الريبو

part 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit(this._attendanceHistoryRepo)
    : super(AttendanceHistoryInitial());

  final AttendanceHistoryRepo _attendanceHistoryRepo;

  Future<void> attendanceHistory({
    required int month,
    required int year,
  }) async {
    emit(AttendanceHistoryLoading());
    try {
      // استدعاء الدالة من الـ repository
      final attendanceRecords = await _attendanceHistoryRepo
          .fetchAttendanceRecords(month, year);
      // في حالة النجاح، قم بإصدار حالة النجاح مع البيانات
      emit(AttendanceHistorySuccess(attendanceRecords));
    } catch (e) {
      // في حالة حدوث خطأ، قم بإصدار حالة الفشل مع رسالة الخطأ
      emit(AttendanceHistoryFailure(e.toString()));
    }
  }
}
