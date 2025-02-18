import 'package:ccapp/calculator_operations/blocs/calculator_bloc.dart';
import 'package:ccapp/calculator_operations/blocs/calculator_event.dart';

class InputOperationsHandle {
  void handleInputOperation(String input, CalculatorBloc bloc) {
    switch (input) {
      case 'C':
        bloc.add(ClearPressed());
        break;
      case 'CE':
        bloc.add(ClearEntryPressed());
        break;
        case '<=':
        bloc.add(BackspacePressed());
        break;
      case '%':
        bloc.add(PercentPressed());
        break;
        case '¹/x':
        bloc.add(ReciprocalPressed());
        break;
        case 'x²':
        bloc.add(SquaredPressed());
        break;
        case '²√x':
        bloc.add(SquareRootPressed());
        break;
      case '=':
        bloc.add(EqualPressed());
        break;
      case '+':
      case '-':
      case '×':
      case '÷':
        bloc.add(OperationPressed(input));
        break;
      case '+/-':
        bloc.add(PlusMinusPressed());
        break;
      case ',':
        bloc.add(DecimalPressed());
        break;
      default:
        bloc.add(NumberPressed(input));
    }
  }
}
