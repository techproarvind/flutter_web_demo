import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/internet_bloc/connectivity_state.dart';

import 'connectivity_event.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState>{

  StreamSubscription? streamSubscription;
  Connectivity _connectivity = Connectivity();
  ConnectivityBloc() : super(ConnectivityInitialState()){

    on<ConnectionLostEvent>((event, emit) => emit(ConnectivityLossState()));
    on<ConnectionGainEvent>((event, emit) => emit(ConnectivityGainState()));

    streamSubscription =  _connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile ){
        add(ConnectionGainEvent());
      }else{
        add(ConnectionLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

}