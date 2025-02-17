class InputMemory {
  static String clear() {
    return '';
  }

  static String clearEntry(String currentInput) {
    if (currentInput.isNotEmpty) return '0';
    return currentInput;
  }

  static String backspace(
      String currentInput, String operation, String previousInput) {
    if (currentInput.isNotEmpty) {
      currentInput = currentInput.substring(0, currentInput.length - 1);
      return currentInput.isEmpty ? '0' : currentInput;
    }

    if (operation.isNotEmpty) {
      operation = '';
    }

    if (previousInput.isNotEmpty) {
      previousInput = previousInput.substring(0, previousInput.length - 1);
      return previousInput.isEmpty ? '0' : previousInput;
    }

    return '0';
  }
}
