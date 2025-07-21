part of 'auth_cubit.dart';

@immutable
sealed class AutheState extends Equatable {}

final class AuthInitial extends AutheState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AutheState {
  @override
  List<Object?> get props => [];
}

final class AuthFailure extends AutheState {
  final String error;
  AuthFailure(this.error);
  //
  @override
  List<Object?> get props => [error];
}

final class AuthSuccess extends AutheState {
  @override
  List<Object?> get props => [];
}
