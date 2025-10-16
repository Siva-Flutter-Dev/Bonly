import '../../domain/entities/login_entity.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginEntity result;
  LoginSuccess({required this.result});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
