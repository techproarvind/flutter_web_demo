import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/network_call_bloc/user_event.dart';

import '../bloc/network_call_bloc/repositories.dart';
import '../bloc/network_call_bloc/user_bloc.dart';
import '../bloc/network_call_bloc/user_state.dart';
import '../dto/UserModel.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc? _userBloc;

  @override
  void initState() {
    _userBloc = UserBloc(UserRepository());
    _userBloc?.add(LoadUserEvent());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('The User App')), body: blocBody());
  }

  Widget blocBody() {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return const Center(child: Text("Error"));
        }
        if (state is LoadedState) {
          List<UserModel> userList = state.users;
          return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                          title: Text(
                            '${userList[index].firstName}  ${userList[index].lastName}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${userList[index].email}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[index].avatar.toString()),
                          ))),
                );
              });
        }

        return Container();
      },
    );
  }
}
