import '../../domain/entities/login_entity.dart';

abstract class LoginState {
  final bool isPasswordVisible;
  final String? email;
  final String? password;
  const LoginState(this.isPasswordVisible,{required this.email,required this.password});
}

class LoginInitial extends LoginState {
  LoginInitial(super.isPasswordVisible, {required super.email, required super.password});
}

class LoginLoading extends LoginState {
  LoginLoading(super.isPasswordVisible, {required super.email, required super.password});
}

class LoginSuccess extends LoginState {
  final LoginEntity result;
  LoginSuccess(super.isPasswordVisible, {required this.result, required super.email, required super.password});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(super.isPasswordVisible, {required this.message, required super.email, required super.password});
}
