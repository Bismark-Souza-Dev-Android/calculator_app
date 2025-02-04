import 'package:ccapp/blocs/calculator_event.dart';
import 'package:ccapp/blocs/calculator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _currentInput = '';
  String _previousInput = '';
  String _operation = '';
  double _memory = 0.0;
  static const int _maxLength = 15;

  CalculatorBloc() : super(CalculatorLoaded('', '')) {
    on<MemoryClear>(_handleMemoryClear);
    on<MemoryRecall>(_handleMemoryRecall);
    on<MemoryAdd>(_handleMemoryAdd);
    on<MemorySubtract>(_handleMemorySubtract);
    on<MemorySave>(_handleMemorySave);
    on<MemoryView>(_handleMemoryView);
    on<NumberPressed>(_handleNumberPressed);
    on<OperationPressed>(_handleOperationPressed);
    on<EqualPressed>(_handleEqualPressed);
    on<ClearPressed>(_handleClearPressed);
    on<ButtonPressed>(_handleButtonPressed);
    on<ClearEntryPressed>(_handleClearEntryPressed);
    on<BackspacePressed>(_handleBackspacePressed);
    on<PercentPressed>(_handlePercentPressed);
  }

  void _handleNumberPressed(
      NumberPressed event, Emitter<CalculatorState> emit) {
    if (_currentInput.length >= _maxLength) return;
    _currentInput += event.number;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleOperationPressed(
      OperationPressed event, Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty) return;
    _previousInput = _currentInput;
    _operation = event.operation;
    _currentInput = '';
    emit(CalculatorLoaded(_getExpression(), ''));
  }

  void _handleEqualPressed(EqualPressed event, Emitter<CalculatorState> emit) {
    if (_isCalculationPossible()) {
      final result = _calculateResult();
      _resetState(result);
      emit(CalculatorLoaded(_getExpression(), result));
    }
  }

  void _handleClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    _resetState();
    emit(CalculatorLoaded('', ''));
  }

  void _handleClearEntryPressed(
      ClearEntryPressed event, Emitter<CalculatorState> emit) {
    if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      emit(CalculatorLoaded(_getExpression(), _currentInput));
    }
  }

  void _handleBackspacePressed(BackspacePressed event, Emitter<CalculatorState> emit) {
    if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length -1);
    } else {
      if (operation.isNotEmpty) {
        _operation = '';
      }
    }
  }

  bool _isCalculationPossible() {
    return _previousInput.isNotEmpty &&
        _currentInput.isNotEmpty &&
        _operation.isNotEmpty;
  }

  String _calculateResult() {
    final number1 = double.tryParse(_previousInput) ?? 0;
    final number2 = double.tryParse(_currentInput) ?? 0;
    double result;

    switch (_operation) {
      case '+':
        result = (number1 + number2);
        break;
      case '-':
        result = (number1 - number2);
        break;
      case '×':
        result = (number1 * number2);
        break;
      case '÷':
        result = number2 != 0 ? number1 / number2 : double.nan;
        break;
      default:
        return 'Erro';
    }

    if (result.isNaN) return 'Error';
    String formattedResult = result % 1 == 0
        ? result.toInt().toString()
        : result
            .toStringAsPrecision(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
    return formattedResult.length > 15
        ? formattedResult.substring(0, 15)
        : formattedResult;
  }

  void _resetState([String result = '']) {
    _currentInput = result;
    _previousInput = '';
    _operation = '';
  }

  String _getExpression() {
    if (_previousInput.isEmpty && _operation.isEmpty) {
      return '';
    }
    return '$_previousInput $_operation'.trim() +
        (_currentInput.isNotEmpty ? ' $_currentInput' : '');
  }

  void _handleButtonPressed(
      ButtonPressed event, Emitter<CalculatorState> emit) {
    final input = event.input;
    final Map<String, CalculatorEvent> eventMap = {
      'C': ClearPressed(),
      'CE': ClearEntryPressed(),
      '<=': BackspacePressed(),
      '=': EqualPressed(),
      '+': OperationPressed('+'),
      '-': OperationPressed('-'),
      '×': OperationPressed('×'),
      '÷': OperationPressed('÷'),
      'MC': MemoryClear(),
      'MR': MemoryRecall(),
      'M+': MemoryAdd(),
      'M-': MemorySubtract(),
      'MS': MemorySave(),
      'Mv': MemoryView()
    };

    if (eventMap.containsKey(input)) {
      add(eventMap[input]!);
    } else {
      add(NumberPressed((input)));
    }
  }

  void _handleMemoryClear(MemoryClear event, Emitter<CalculatorState> emit) {
    _memory = 0.0;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemoryRecall(MemoryRecall event, Emitter<CalculatorState> emit) {
    _currentInput = _memory.toString();
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemoryAdd(MemoryAdd event, Emitter<CalculatorState> emit) {
    _memory += double.tryParse(_currentInput) ?? 0;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemorySubtract(
      MemorySubtract event, Emitter<CalculatorState> emit) {
    _memory -= double.tryParse(_currentInput) ?? 0;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemorySave(MemorySave event, Emitter<CalculatorState> emit) {
    _memory = double.tryParse(_currentInput) ?? 0;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemoryView(MemoryView event, Emitter<CalculatorState> emit) {
    _currentInput = _memory.toString();
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }
}
