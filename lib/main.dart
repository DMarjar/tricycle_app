import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';
import 'repositories/tricycle_repository.dart';
import 'blocs/tricycle_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TricycleRepository tricycleRepository = TricycleRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TricycleBloc(tricycleRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AWS Lambda Flutter',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: HomeScreen(tricycleRepository: tricycleRepository),
      ),
    );
  }
}
