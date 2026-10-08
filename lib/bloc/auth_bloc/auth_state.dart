import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.message});

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
