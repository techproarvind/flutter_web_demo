import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_bloc.dart';
import 'package:internet_connection/bloc/internet_bloc/connectivity_bloc.dart';
import 'package:internet_connection/cubit/user_cubit.dart';

import 'bloc/network_call_bloc/repositories.dart';
import 'bloc/network_call_bloc/user_bloc.dart';
import 'ui/cubit_connection.dart';
import 'ui/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (BuildContext context) => ConnectivityBloc(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Cubit Home Page'),
      ),
    );
  }
}
