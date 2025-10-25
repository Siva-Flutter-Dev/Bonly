import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';

abstract class RegisterState {
  final bool isPasswordVisible;
  RegisterState(this.isPasswordVisible);
}

class RegisterInitial extends RegisterState {
  RegisterInitial(super.isPasswordVisible);
}

class RegisterLoading extends RegisterState {
  RegisterLoading(super.isPasswordVisible);
}

class RegisterSuccess extends RegisterState {
  final RegisterEntity result;

  RegisterSuccess(super.isPasswordVisible, {required this.result});
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(super.isPasswordVisible, {required this.message});
}
