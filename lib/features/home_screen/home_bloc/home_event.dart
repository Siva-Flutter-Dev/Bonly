
abstract class HomeEvent {}

class ChangeTabEvent extends HomeEvent {
  final int newIndex;
  ChangeTabEvent(this.newIndex);
}
