import 'package:attendance_appp/features/record_attendance/data/models/record_attendance.dart';
import 'package:attendance_appp/features/record_attendance/data/repos_impl/record_attendance_repo_impl.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'record_attendance_state.dart';

class RecordAttendanceCubit extends Cubit<RecordAttendanceState> {
  RecordAttendanceCubit(this._recordAttendanceRepo)
    : super(RecordAttendanceInitial());

  final RecordAttendanceRepo _recordAttendanceRepo;
  Future<void> recordAttendance(AttendanceRecordModel record) async {
    emit(RecordAttendanceLoading());

    var result = await _recordAttendanceRepo.recordAttendance(record);
    result.fold(
      (failure) {
        emit(RecordAttendanceFailure(failure.message));
      },
      (_) {
        emit(RecordAttendanceSuccess());
      },
    );
  }

  Future<void> updateRecordAttendance(AttendanceRecordModel record) async {
    emit(RecordAttendanceLoading());

    var result = await _recordAttendanceRepo.updateAttendance(record);
    result.fold(
      (failure) {
        emit(RecordAttendanceFailure(failure.message));
      },
      (_) {
        emit(RecordAttendanceSuccess());
      },
    );
  }
}
