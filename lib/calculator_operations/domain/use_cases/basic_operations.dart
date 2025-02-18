class BasicOperations {
  static String basicOperations(
      String previousInput, String currentInput, String operation) {
    final number1 = double.tryParse(previousInput) ?? 0;
    final number2 = double.tryParse(currentInput) ?? 0;
    double result;

    switch (operation) {
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

    if (result.isNaN) return 'Erro ao Dividir por zero';
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
}
