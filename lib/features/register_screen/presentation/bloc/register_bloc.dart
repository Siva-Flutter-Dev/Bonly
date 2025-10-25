import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial(false)) {
    on<RegisterButtonPressed>(_onRegister);
    on<TogglePasswordRegister>(_togglePassword);
  }

  Future<void> _onRegister(
      RegisterButtonPressed event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading(state.isPasswordVisible));

    final result = await registerUser(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(RegisterFailure(state.isPasswordVisible,message:failure.message)),
          (r) => emit(RegisterSuccess(state.isPasswordVisible,result:r)),
    );
  }

  void _togglePassword(
      TogglePasswordRegister event,
      Emitter<RegisterState> emit,
      ) {
    final newVisibility = !state.isPasswordVisible;

    if (state is RegisterInitial) {
      emit(RegisterInitial(newVisibility));
    } else if (state is RegisterLoading) {
      emit(RegisterLoading(newVisibility));
    } else if (state is RegisterSuccess) {
      emit(RegisterSuccess(newVisibility, result: (state as RegisterSuccess).result));
    } else if (state is RegisterFailure) {
      emit(RegisterFailure(newVisibility, message: (state as RegisterFailure).message));
    } else {
      emit(RegisterInitial(newVisibility));
    }
  }
}
