class NumericInput {
  static const int maxLength = 15;

  static String handleNumberInput(String currentInput, String number) {
    if (currentInput.length >= maxLength) return currentInput;
    if (currentInput == '0' && number != '0') {
      return number;
    } else {
      return currentInput += number;
    }
  }

  static String handleDecimalInput(String currentInput) {
    if (!currentInput.contains('.')) {
      return currentInput.isEmpty ? '0.' : currentInput += '.';
    }
    return currentInput;
  }
}
