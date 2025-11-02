abstract class BlogEvent{}

class TabBarEvent extends BlogEvent{
  final int index;
  TabBarEvent({required this.index});
}

class BlogFetched extends BlogEvent{}