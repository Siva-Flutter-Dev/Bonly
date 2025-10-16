
abstract class HomeState {
  final int index;
  const HomeState({required this.index});
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(index: 0);
}

class HomeIndexChanged extends HomeState {
  const HomeIndexChanged({required super.index});
}
