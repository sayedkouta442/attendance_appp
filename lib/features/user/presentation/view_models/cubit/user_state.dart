part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFailure extends UserState {
  final String errMessage;

  const UserFailure(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}

final class UserSuccess extends UserState {
  final UserModel user;

  const UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}
