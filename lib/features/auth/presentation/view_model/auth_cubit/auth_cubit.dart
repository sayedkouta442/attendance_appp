import 'package:attendance_appp/features/auth/data/repos_imple/repos_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AutheState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> signinWithEmail({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await authRepo.signInWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (r) => emit(AuthSuccess()),
    );
  }
}
