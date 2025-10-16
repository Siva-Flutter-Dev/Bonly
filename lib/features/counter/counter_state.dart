abstract class CounterState{
  int counter;
  CounterState({required this.counter});
}

class CounterInitial extends CounterState{
  CounterInitial():super(counter: 0);
}

class CounterIncrease extends CounterState{
  CounterIncrease(int increase):super(counter: increase);
}

class CounterDecrease extends CounterState{
  CounterDecrease(int decrease):super(counter: decrease);
}