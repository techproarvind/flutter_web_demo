import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_bloc.dart';
import 'package:internet_connection/bloc/internet_bloc/connectivity_bloc.dart';
import 'package:internet_connection/bloc/internet_bloc/connectivity_state.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:internet_connection/ui/sign_in/sign_in_page.dart';
import 'package:internet_connection/ui/user_page.dart';

import '../bloc/counter_bloc/counter_event.dart';
import 'counter_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var countBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          BlocBuilder(
            bloc: countBloc,
            buildWhen: (current, previous) => current != previous,
            builder: (context, state) {
              return Text(countBloc.state.counter.toString());
            },
          )
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivityGainState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("gain")));
              } else if (state is ConnectivityLossState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("loass")));
              }
            },
            builder: (context, state) {
              return BlocBuilder<ConnectivityBloc, ConnectivityState>(
                bloc: ConnectivityBloc(),
                builder: (context, state) {
                  if (state is ConnectivityGainState) {
                    return const Center(
                        child: Text("Gain",
                            style:
                                TextStyle(color: Colors.green, fontSize: 21)));
                  } else if (state is ConnectivityLossState) {
                    return const Center(
                        child: Text(
                      " loss",
                      style: TextStyle(color: Colors.red, fontSize: 21),
                    ));
                  }
                  return const Center(
                      child: Text("Internet Connection Listener"));
                },
              );
            },
          ),
          BlocBuilder(
            bloc: countBloc,
            builder: (context, state) {
              return Text(countBloc.state.counter.toString());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  countBloc.add(Increment());
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 12,
              ),
              FloatingActionButton(
                onPressed: () {
                  countBloc.add(Decrement());
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(
                width: 12,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CountItemPage()));
                },
                child: const Icon(Icons.tap_and_play_outlined),
              ),
              SizedBox(width: 12,),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => SignInBloc(),
                                child: SignInPage(),
                              )));
                },
                child: const Icon(Icons.sign_language_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
