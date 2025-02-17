class MemoryOperations {
  double? memory;

  void save(String value) {
    memory = double.tryParse(value) ?? 0.0;
  }

  void add(String value) {
    memory = (memory ?? 0.0) + (double.tryParse(value) ?? 0.0);
  }

  void subtract(String value) {
    memory = (memory ?? 0.0) - (double.tryParse(value) ?? 0.0);
  }

  String recall() {
    return memory?.toString() ?? '0';
  }

  void clear() {
    memory = null;
  }

  void view(String value) {
    memory = double.tryParse(value) ?? 0.0;
  }

  bool hasMemory() {
    return memory != null;
  }
}
