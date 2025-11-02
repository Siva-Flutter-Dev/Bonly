import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validators/validators.dart';
import '../../domain/usecases/profile_save_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial(
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
      nameError: null,
      emailError: null,
      passwordError: null,
      confirmPasswordError: null,
  )) {
    on<RegisterButtonPressed>(_onRegister);
    on<TogglePasswordRegister>(_togglePassword);
    on<ToggleConfirmPasswordRegister>(_toggleConfirmPassword);
    on<NameChangedRegister>(_nameChange);
    on<EmailChangedRegister>(_emailChange);
    on<PasswordChangedRegister>(_passwordChange);
    on<ConfirmPasswordChangedRegister>(_confirmPasswordChange);
  }

  Future<void> _onRegister(RegisterButtonPressed event, Emitter<RegisterState> emit,) async {
    emit(RegisterLoading(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));

    final result = await registerUser(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));



    result.fold(
          (failure) {
            emit(RegisterFailure(
              message: failure.message,
              isPasswordVisible: state.isPasswordVisible,
              isConfirmPasswordVisible: state.isConfirmPasswordVisible,
              nameError: state.nameError,
              emailError: state.emailError,
              passwordError: state.passwordError,
              confirmPasswordError: state.confirmPasswordError,
            ));
            },
          (r){
            emit(RegisterSuccess(
              result: r,
              isPasswordVisible: state.isPasswordVisible,
              isConfirmPasswordVisible: state.isConfirmPasswordVisible,
              nameError: state.nameError,
              emailError: state.emailError,
              passwordError: state.passwordError,
              confirmPasswordError: state.confirmPasswordError,
            ));
            },
    );
  }

  void _togglePassword(TogglePasswordRegister event, Emitter<RegisterState> emit,) {
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));
  }

  void _toggleConfirmPassword(ToggleConfirmPasswordRegister event, Emitter<RegisterState> emit,) {
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));
  }

  void _nameChange(NameChangedRegister event,emit){
    final nameError = event.name.isEmpty ?"Name is Required":event.name.length<3?"Name must be 3 characters":null;
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: nameError,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));
  }

  void _emailChange(EmailChangedRegister event,emit){
    final emailError = !AppValidators.isEmailValid(event.email)||event.email.isEmpty?'Enter valid email':null;
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: emailError,
      passwordError: state.passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));
  }

  void _passwordChange(PasswordChangedRegister event,emit){
    final passwordError = event.password.isEmpty || event.password.length<=6?'Password must be 6 characters':null;
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: state.emailError,
      passwordError: passwordError,
      confirmPasswordError: state.confirmPasswordError,
    ));
  }

  void _confirmPasswordChange(ConfirmPasswordChangedRegister event,emit){
    final confirmPasswordError = event.password.isEmpty ||
        event.password.length<=6
        ?'Password must be 6 characters'
        :event.password != event.confirmPassword
        ?"Password do not matched":null;
    emit(OnChangeState(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      nameError: state.nameError,
      emailError: state.emailError,
      passwordError: state.passwordError,
      confirmPasswordError: confirmPasswordError,
    ));
  }
}
