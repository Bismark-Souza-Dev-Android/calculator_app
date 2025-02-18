import 'package:ccapp/calculator_operations/blocs/calculator_event.dart';
import 'package:ccapp/calculator_operations/blocs/calculator_state.dart';
import 'package:ccapp/calculator_operations/domain/use_cases/basic_operations.dart';
import 'package:ccapp/calculator_operations/domain/use_cases/input_control.dart';
import 'package:ccapp/calculator_operations/domain/use_cases/memory_operations.dart';
import 'package:ccapp/calculator_operations/domain/use_cases/numeric_input.dart';
import 'package:ccapp/calculator_operations/domain/use_cases/special_operations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _currentInput = '';
  String _previousInput = '';
  String _operation = '';
  bool _shouldReset = false;
  final MemoryOperations _memoryOperations = MemoryOperations();

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
    on<ClearEntryPressed>(_handleClearEntryPressed);
    on<BackspacePressed>(_handleBackspacePressed);
    on<PercentPressed>(_handlePercentPressed);
    on<ReciprocalPressed>(_handleReciprocalPressed);
    on<DecimalPressed>(_handleDecimalPressed);
    on<SquareRootPressed>(_handleSquareRootPressed);
    on<SquaredPressed>(_handleSquaredPressed);
    on<PlusMinusPressed>(_handlePlusMinusPressed);
  }

  void _handleSquareRootPressed(SquareRootPressed event,
      Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty) return;
    _currentInput = SpecialOperations.squareRoot(_currentInput);
    _shouldReset = true;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handlePlusMinusPressed(PlusMinusPressed event,
      Emitter<CalculatorState> emit) {
    _currentInput = SpecialOperations.plusMinus(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleSquaredPressed(SquaredPressed event,
      Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty) return;
    _currentInput = SpecialOperations.squared(_currentInput);
    _shouldReset = true;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleReciprocalPressed(ReciprocalPressed event,
      Emitter<CalculatorState> emit) {
    _currentInput = SpecialOperations.reciprocal(_currentInput);
    _shouldReset = true;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleDecimalPressed(DecimalPressed event,
      Emitter<CalculatorState> emit) {
    _currentInput = NumericInput.handleDecimalInput(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleNumberPressed(NumberPressed event,
      Emitter<CalculatorState> emit) {
    if (_shouldReset) {
      _currentInput = event.number;
      _shouldReset = false;
    } else {
      _currentInput =
          NumericInput.handleNumberInput(_currentInput, event.number);
    }
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleOperationPressed(OperationPressed event, Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty) {
      _previousInput = '0';
    } else {
      _previousInput = _currentInput;
      _currentInput = '';
    }
    _operation = event.operation;
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }



  void _handleEqualPressed(EqualPressed event, Emitter<CalculatorState> emit) {
    if (_isCalculationPossible()) {
      final result = _calculateResult();
      _resetState(result);
      _shouldReset = true;
      emit(CalculatorLoaded(_getExpression(), result));
    }
  }

  void _handleClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    _resetState();
    emit(CalculatorLoaded('', ''));
  }

  void _handleClearEntryPressed(ClearEntryPressed event,
      Emitter<CalculatorState> emit) {
    _currentInput = InputMemory.clearEntry(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleBackspacePressed(BackspacePressed event,
      Emitter<CalculatorState> emit) {
    _currentInput =
        InputMemory.backspace(_currentInput, _previousInput, _operation);
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handlePercentPressed(PercentPressed event,
      Emitter<CalculatorState> emit) {
    _currentInput = SpecialOperations.percent(_previousInput, _currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  bool _isCalculationPossible() {
    return _previousInput.isNotEmpty &&
        _currentInput.isNotEmpty &&
        _operation.isNotEmpty;
  }

  String _calculateResult() {
    _currentInput = BasicOperations.basicOperations(
        _previousInput, _currentInput, _operation);
    return _currentInput;
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

  void _handleMemoryClear(MemoryClear event, Emitter<CalculatorState> emit) {
    _memoryOperations.clear();
    emit(CalculatorLoaded(_getExpression(), _currentInput, hasMemory: false));
  }

  void _handleMemoryRecall(MemoryRecall event, Emitter<CalculatorState> emit) {
    _currentInput = _memoryOperations.recall();
    emit(CalculatorLoaded(_getExpression(), _currentInput));
  }

  void _handleMemoryAdd(MemoryAdd event, Emitter<CalculatorState> emit) {
    _memoryOperations.add(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput,
        hasMemory: _memoryOperations.hasMemory()));
  }

  void _handleMemorySubtract(MemorySubtract event,
      Emitter<CalculatorState> emit) {
    _memoryOperations.subtract(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput,
        hasMemory: _memoryOperations.hasMemory()));
  }

  void _handleMemorySave(MemorySave event, Emitter<CalculatorState> emit) {
    _memoryOperations.save(_currentInput);
    emit(CalculatorLoaded(_getExpression(), _currentInput, hasMemory: true));
  }

  void _handleMemoryView(MemoryView event, Emitter<CalculatorState> emit) {
    final memoryValue = _memoryOperations.recall();
    emit(CalculatorMemoryView(
      memoryValue: memoryValue,
      expression: _getExpression(),
      result: _currentInput,
    ));
  }

}
