import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegister);
  }

  Future<void> _onRegister(
      RegisterButtonPressed event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());

    final result = await registerUser(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
          (failure) => emit(RegisterFailure(message:failure.message)),
          (r) => emit(RegisterSuccess(result:r)),
    );
  }
}
