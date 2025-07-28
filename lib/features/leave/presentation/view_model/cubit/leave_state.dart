part of 'leave_cubit.dart';

sealed class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

final class LeaveInitial extends LeaveState {}

final class LeaveLoading extends LeaveState {}

final class LeaveFailure extends LeaveState {
  final String errMessage;

  const LeaveFailure(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}

final class LeaveSuccess extends LeaveState {
  final LeaveModel leaveRequestModel;

  const LeaveSuccess(this.leaveRequestModel);
}
