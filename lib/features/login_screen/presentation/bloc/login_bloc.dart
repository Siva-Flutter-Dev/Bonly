import 'package:bondly/features/login_screen/domain/usecases/login_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;

  LoginBloc({required this.loginUser}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
     final result = await loginUser(LoginParams(
            email: event.email,
            password: event.password
        ));
    print("Login Bloc=====Success");
    result.fold(
          (failure) => emit(LoginFailure(message: failure.message)),
          (r) => emit(LoginSuccess(result: r)),
    );
  }
}

