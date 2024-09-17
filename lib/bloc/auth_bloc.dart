// lib/bloc/auth_bloc.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modern_transportation/repositories/auth_repository.dart'; // Import the repository
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository; // Add the repository

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested); // Handle Sign-Up

  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final token = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      // You can store the token if needed
      emit(AuthSuccess(uid: token)); // Assuming 'uid' is the token
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Implement logout logic if necessary
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  // New Sign-Up Handler
  void _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signUp(
        fullName: event.fullName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      emit(AuthSuccess(uid: 'SignedUp')); // You might want a different state
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

}
