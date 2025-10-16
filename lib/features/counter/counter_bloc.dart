import 'package:bondly/features/counter/counter_event.dart';
import 'package:bondly/features/counter/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc():super(CounterInitial()){
    on<CounterIncreaseEvent>((event,emit){
      emit(CounterIncrease(state.counter+1));
  });
    on<CounterDecreaseEvent>((event,emit){
      emit(CounterDecrease(state.counter-1));
  });
  }
}