import 'package:bondly/features/register_screen/domain/entities/user_entities.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterEntity result;

  RegisterSuccess({required this.result});
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message});
}
