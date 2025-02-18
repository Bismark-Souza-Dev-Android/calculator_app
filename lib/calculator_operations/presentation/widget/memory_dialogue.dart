import 'package:flutter/material.dart';

class MemoryDialogue extends StatelessWidget {
  final String memoryValue;

  const MemoryDialogue({super.key, required this.memoryValue});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Memória'),
        content: Text('O valor da memória é: $memoryValue'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ]);
  }
}
