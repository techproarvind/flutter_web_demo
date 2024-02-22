import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/network_call_bloc/repositories.dart';
import 'package:internet_connection/bloc/network_call_bloc/user_event.dart';
import 'package:internet_connection/bloc/network_call_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository? userRepository ;

  UserBloc(this.userRepository) : super(LoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final users = await userRepository?.getUsers();
        emit(LoadedState(users!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}