import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromAuthException(AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return ServerFailure('Invalid email or password.');
    } else if (message.contains('email not confirmed')) {
      return ServerFailure('Please confirm your email before logging in.');
    } else if (message.contains('user already registered')) {
      return ServerFailure('Email is already registered.');
    } else if (message.contains('user not found')) {
      return ServerFailure('No user found with this email.');
    } else if (message.contains('network error')) {
      return ServerFailure(
        'Network error. Please check your internet connection.',
      );
    } else {
      return ServerFailure('Authentication failed. Please try again.');
    }
  }
}
