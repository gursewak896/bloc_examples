import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_bloc/bloc/internet_bloc.dart';
import 'package:internet_bloc/bloc/internet_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          builder: (context, state) {
            if (state is InternetGainedState) {
              return const Text('Connected');
            } else if (state is InternetLostState) {
              return const Text('Not Connected');
            } else {
              return const Text('Loading...');
            }
          },
          listener: (context, state) {
            if (state is InternetGainedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Internet Connected"),
                backgroundColor: Colors.green,
              ));
            } else if (state is InternetLostState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Internet Disconnected"),
                backgroundColor: Colors.red,
              ));
            }
          },
        ),
      ),
    );
  }
}
