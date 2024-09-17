part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

final class AuthLogoutRequested extends AuthEvent {}
// New Sign-Up Event
final class AuthSignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  AuthSignUpRequested({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}