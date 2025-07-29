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

final class LeaveRequestSuccess extends LeaveState {
  final LeaveModel leaveRequestModel;

  const LeaveRequestSuccess(this.leaveRequestModel);
}

final class LeaveStatusSuccess extends LeaveState {
  final List<LeaveModel> leave;

  const LeaveStatusSuccess(this.leave);
}
