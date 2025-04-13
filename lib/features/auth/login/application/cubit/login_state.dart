part of 'login_cubit.dart';

class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LoginStateError extends LoginState {
  String message;

  LoginStateError({required this.message});
}
