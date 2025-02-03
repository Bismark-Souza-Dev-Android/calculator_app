import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/calculator_bloc.dart';
import 'feature/calculator/presentation/calculator_screen.dart';

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
