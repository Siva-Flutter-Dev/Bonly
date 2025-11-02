import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';

abstract class RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  RegisterState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.nameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
  });
}

class RegisterInitial extends RegisterState {
  RegisterInitial({required super.isPasswordVisible, required super.isConfirmPasswordVisible, required super.nameError, required super.emailError, required super.passwordError, required super.confirmPasswordError});
}

class RegisterLoading extends RegisterState {
  RegisterLoading({required super.isPasswordVisible, required super.isConfirmPasswordVisible, required super.nameError, required super.emailError, required super.passwordError, required super.confirmPasswordError});
}

class OnChangeState extends RegisterState{
  OnChangeState({required super.isPasswordVisible, required super.isConfirmPasswordVisible, required super.nameError, required super.emailError, required super.passwordError, required super.confirmPasswordError});
}

class RegisterSuccess extends RegisterState {
  final RegisterEntity result;

  RegisterSuccess({required this.result, required super.isPasswordVisible, required super.isConfirmPasswordVisible, required super.nameError, required super.emailError, required super.passwordError, required super.confirmPasswordError});
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message, required super.isPasswordVisible, required super.isConfirmPasswordVisible, required super.nameError, required super.emailError, required super.passwordError, required super.confirmPasswordError});
}
