abstract class CalculatorState {
  final String expression;
final String result;
  final bool hasMemory;

  const CalculatorState(this.expression, this.result, {this.hasMemory = false});
}

class CalculatorLoading extends CalculatorState {
  const CalculatorLoading() : super('', '');
}

class CalculatorLoaded extends CalculatorState {
  const CalculatorLoaded(super.expression, super.result,
      {super.hasMemory = false});
}

class CalculatorMemoryView extends CalculatorState {
  final String memoryValue;

  const CalculatorMemoryView({
    required this.memoryValue,
    required String expression,
    required String result,
    bool hasMemory = true,
  }) : super(expression, result, hasMemory: hasMemory);
}
