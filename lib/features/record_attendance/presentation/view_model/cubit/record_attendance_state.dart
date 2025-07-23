part of 'record_attendance_cubit.dart';

sealed class RecordAttendanceState extends Equatable {
  const RecordAttendanceState();

  @override
  List<Object> get props => [];
}

final class RecordAttendanceInitial extends RecordAttendanceState {}

final class RecordAttendanceLoading extends RecordAttendanceState {}

final class RecordAttendanceFailure extends RecordAttendanceState {
  final String errorMessage;

  const RecordAttendanceFailure(this.errorMessage);
}

final class RecordAttendanceSuccess extends RecordAttendanceState {}
