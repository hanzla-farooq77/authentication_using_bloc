import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginSubmitted>(_login);
    on<SignUpSubmitted>(_signUp);
  }

  Future<void> _login(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    if (event.email == 'test@gmail.com' && event.password == '123456') {
      emit(
        state.copyWith(status: AuthStatus.success, message: 'Login successful'),
      );
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: 'Invalid email or password',
        ),
      );
    }
  }

  Future<void> _signUp(SignUpSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        status: AuthStatus.success,
        message: 'Account created successfully',
      ),
    );
  }
}
