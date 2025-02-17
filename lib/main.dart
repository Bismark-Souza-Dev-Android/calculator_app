import 'package:ccapp/calculator_operations/blocs/calculator_bloc.dart';
import 'package:ccapp/calculator_operations/presentation/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CalculatorBloc(),
      child: MaterialApp(
        home: CalculatorScreen(),
      ),
    ),
  );
}
