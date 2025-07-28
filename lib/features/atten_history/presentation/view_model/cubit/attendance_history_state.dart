part of 'attendance_history_cubit.dart';

sealed class AttendanceHistoryState extends Equatable {
  const AttendanceHistoryState();

  @override
  List<Object> get props => [];
}

final class AttendanceHistoryInitial extends AttendanceHistoryState {}

final class AttendanceHistoryLoading extends AttendanceHistoryState {
  @override
  List<Object> get props => [];
}

final class AttendanceHistoryFailure extends AttendanceHistoryState {
  final String errMessage;

  const AttendanceHistoryFailure(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}

final class AttendanceHistorySuccess extends AttendanceHistoryState {
  final List<AttendanceRecord> attendance;

  const AttendanceHistorySuccess(this.attendance);
  @override
  List<Object> get props => [attendance];
}
