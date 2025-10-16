import 'dart:async';
import 'package:bondly/features/splash_screen/splash_bloc/splash_event.dart';
import 'package:bondly/features/splash_screen/splash_bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>(_onStartSplash);
  }

  Future<void> _onStartSplash(
      StartSplashEvent event,
      Emitter<SplashState> emit,
      ) async {
    await Future.delayed(Duration(seconds: 3));
    emit(SplashLoaded());
  }
}
