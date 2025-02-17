abstract class CalculatorEvent {}

class NumberPressed extends CalculatorEvent {
  final String number;

  NumberPressed(this.number);
}

class OperationPressed extends CalculatorEvent {
  final String operation;

  OperationPressed(this.operation);
}

class EqualPressed extends CalculatorEvent {}

class ClearPressed extends CalculatorEvent {}

class ClearEntryPressed extends CalculatorEvent {}

class BackspacePressed extends CalculatorEvent {}

class ButtonPressed extends CalculatorEvent {
  final String input;

  ButtonPressed(this.input);
}

class MemoryClear extends CalculatorEvent {}

class MemoryRecall extends CalculatorEvent {}

class MemoryAdd extends CalculatorEvent {}

class MemorySubtract extends CalculatorEvent {}

class MemorySave extends CalculatorEvent {}

class MemoryView extends CalculatorEvent {}

class PercentPressed extends CalculatorEvent {}

class ReciprocalPressed extends CalculatorEvent {}

class SquaredPressed extends CalculatorEvent {}

class DecimalPressed extends CalculatorEvent {}

class SquareRootPressed extends CalculatorEvent {}

class PlusMinusPressed extends CalculatorEvent {}
