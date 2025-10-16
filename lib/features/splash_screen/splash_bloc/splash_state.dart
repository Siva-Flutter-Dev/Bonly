abstract class SplashState {
  final bool isLoaded;
  const SplashState({required this.isLoaded});
}

class SplashInitial extends SplashState {
  SplashInitial() : super(isLoaded: false);
}

class SplashLoaded extends SplashState {
  SplashLoaded() : super(isLoaded: true);
}
