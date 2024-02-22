import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_bloc.dart';
import 'package:internet_connection/bloc/counter_bloc/counter_state.dart';

import '../bloc/counter_bloc/counter_event.dart';

class CountItemPage extends StatelessWidget {
  const CountItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    var countBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Count"),
        actions: [

        ],
      ),
      body: Center(child: BlocBuilder(
        bloc: countBloc,
        builder: (context, state) {
          return Text(countBloc.state.counter.toString());
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countBloc.add(Increment());
        },
        child: Icon(Icons.do_not_disturb_on_total_silence),
      ),
    );
  }
}
