import 'package:bondly/core/validators/validators.dart';
import 'package:bondly/features/login_screen/domain/usecases/login_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial(false,email: null,password: null)) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePassword>(_togglePassword);
    on<EmailChangedLogin>(_emailChangedLogin);
    on<PasswordChangedLogin>(_passwordChangedLogin);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading(state.isPasswordVisible,email: state.email,password: state.password));
     final result = await loginUser(LoginParams(
            email: event.email,
            password: event.password
        ));
    result.fold(
          (failure) => emit(LoginFailure(state.isPasswordVisible,message: "Invalid Email or Password",email: state.email,password: state.password)),
          (r) => emit(LoginSuccess(state.isPasswordVisible,result: r, email: state.email, password: state.password)),
    );
  }

  void _togglePassword(
      TogglePassword event,
      Emitter<LoginState> emit,
      ) {
    final newVisibility = !state.isPasswordVisible;

    if (state is LoginInitial) {
      emit(LoginInitial(newVisibility, email: state.email, password: state.password));
    } else if (state is LoginLoading) {
      emit(LoginLoading(newVisibility, email: state.email, password: state.password));
    } else if (state is LoginSuccess) {
      emit(LoginSuccess(newVisibility, result: (state as LoginSuccess).result, email: state.email, password: state.password));
    } else if (state is LoginFailure) {
      emit(LoginFailure(newVisibility, message: (state as LoginFailure).message, email: state.email, password: state.password));
    } else {
      emit(LoginInitial(newVisibility, email: state.email, password: state.password));
    }
  }

  void _emailChangedLogin(EmailChangedLogin event, Emitter<LoginState> emit,){
    final newVisibility = state.isPasswordVisible;
    final emailError=!AppValidators.isEmailValid(event.email)||event.email.isEmpty?'Enter valid email':null;
    if (state is LoginInitial) {
      emit(LoginInitial(newVisibility, email: emailError, password: state.password));
    } else if (state is LoginLoading) {
      emit(LoginLoading(newVisibility, email: emailError, password: state.password));
    } else if (state is LoginSuccess) {
      emit(LoginSuccess(newVisibility, result: (state as LoginSuccess).result, email: emailError, password: state.password));
    } else if (state is LoginFailure) {
      emit(LoginFailure(newVisibility, message: (state as LoginFailure).message, email: emailError, password: state.password));
    } else {
      emit(LoginInitial(newVisibility, email: emailError, password: state.password));
    }
  }

  void _passwordChangedLogin(PasswordChangedLogin event, Emitter<LoginState> emit,){
    final newVisibility = state.isPasswordVisible;
    final passwordError=event.password.isEmpty || event.password.length<=6?'Password must be 6 characters':null;
    if (state is LoginInitial) {
      emit(LoginInitial(newVisibility, email: state.email, password: passwordError));
    } else if (state is LoginLoading) {
      emit(LoginLoading(newVisibility, email: state.email, password: passwordError));
    } else if (state is LoginSuccess) {
      emit(LoginSuccess(newVisibility, result: (state as LoginSuccess).result, email: state.email, password: passwordError));
    } else if (state is LoginFailure) {
      emit(LoginFailure(newVisibility, message: (state as LoginFailure).message, email: state.email, password: passwordError));
    } else {
      emit(LoginInitial(newVisibility, email: state.email, password: passwordError));
    }
  }
}

