
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UserCubitState{initial, lost, gain}

class UserCubit extends Cubit<UserCubitState>{
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  UserCubit() : super(UserCubitState.initial){

    streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile){
        emit(UserCubitState.gain);
      }else{
        emit(UserCubitState.lost);
      }
    });

  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}