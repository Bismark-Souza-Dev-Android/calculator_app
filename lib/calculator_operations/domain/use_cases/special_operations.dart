import 'dart:math';

class SpecialOperations {
  static String reciprocal(String input) {
    double number = double.tryParse(input) ?? 0;

    if (number == 0) return 'Erro';
    return (1 / number)
        .toStringAsPrecision(10)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  static String percent(String previousInput, String currentInput) {
    double number = double.tryParse(currentInput) ?? 0;
    double previousNumber = double.tryParse(previousInput) ?? 0.0;
    double numberPercent = previousNumber * (number / 100);

    if (numberPercent % 1 == 0) {
      return numberPercent.toInt().toString();
    } else {
      return numberPercent.toString();
    }
  }

  static String squareRoot(String input) {
    final number = double.tryParse(input);

    if (number == null || number < 0) {
      return 'Erro';
    }

    final result = sqrt(number);
    return result % 1 == 0
        ? result.toInt().toString()
        : result
            .toStringAsPrecision(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
  }

  static String squared(String input) {
    final number = double.tryParse(input);

    if (number == null || number < 0) {
      return 'Erro';
    }

    final result = number * number;
    return result % 1 == 0
        ? result.toInt().toString()
        : result
            .toStringAsPrecision(10)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
  }
}
