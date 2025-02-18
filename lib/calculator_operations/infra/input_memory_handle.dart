import 'package:ccapp/calculator_operations/blocs/calculator_bloc.dart';
import 'package:ccapp/calculator_operations/blocs/calculator_event.dart';

class InputMemoryHandle {
  void handleMemoryInput(String input, CalculatorBloc bloc) {
    switch (input) {
      case 'Mc':
        bloc.add(MemoryClear());
        break;
      case 'Mr':
        bloc.add(MemoryRecall());
        break;
      case 'M+':
        bloc.add(MemoryAdd());
        break;
      case 'M-':
        bloc.add(MemorySubtract());
        break;case 'Ms':
        bloc.add(MemorySave());
        break;
      default:
        bloc.add(MemoryView());
    }
  }
}