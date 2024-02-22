
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/cubit/user_cubit.dart';

class MyHomePageCubit extends StatefulWidget {
  const MyHomePageCubit({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageCubit> createState() => _MyHomePageCubitState();
}

class _MyHomePageCubitState extends State<MyHomePageCubit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          BlocBuilder<UserCubit, UserCubitState>(
            bloc: UserCubit(),
            builder: (context, state) {
              if (state == UserCubitState.gain) {
                return const Center(
                    child: Text("Gain Cubit",
                        style:
                        TextStyle(color: Colors.green, fontSize: 21)));
              } else if (state == UserCubitState.lost) {
                return const Center(
                    child: Text(
                      " loss Cubit",
                      style: TextStyle(color: Colors.red, fontSize: 21),
                    ));
              }
              return const Center(child: Text("Cubit Internet Connection Listener"));

            },
          ),

        ],
      ),
    );
  }
}