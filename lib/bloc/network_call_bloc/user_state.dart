
import 'package:equatable/equatable.dart';
import '../../dto/UserModel.dart';

abstract class UserState extends Equatable{}


class LoadingState extends UserState{
  @override
  List<Object?> get props => [];
}


class LoadedState extends UserState{
  final List<UserModel> users;
  LoadedState(this.users);

  @override
  List<Object?> get props => [users];
}


class ErrorState extends UserState{

  final String error;
  ErrorState(this.error);
  @override
  List<Object?> get props => [error];
}