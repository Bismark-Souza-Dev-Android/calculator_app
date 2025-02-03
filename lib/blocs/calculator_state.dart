abstract class CalculatorState {
  final String expression;
  final String result;

  const CalculatorState(this.expression, this.result);
}

class CalculatorLoading extends CalculatorState {
  const CalculatorLoading() : super('', '');
}

class CalculatorLoaded extends CalculatorState {
  const CalculatorLoaded(super.expression, super.result);
}
