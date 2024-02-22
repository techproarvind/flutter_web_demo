import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_event.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvents, CounterStates>{

  CounterBloc():super(InitialState()){

    on<Increment>((event, emit){
      emit(CounterStates(counter: state.counter+1));
    });

    on<Decrement>((event, emit){
      if(state.counter <= 0){
        return;
      }
      emit(CounterStates(counter:state.counter-1));
    });
  }
}