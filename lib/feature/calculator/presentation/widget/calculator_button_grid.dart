import 'package:ccapp/core/get_button_color.dart';
import 'package:ccapp/feature/calculator/presentation/widget/button_number.dart';
import 'package:ccapp/feature/calculator/presentation/widget/memory_button.dart';
import 'package:flutter/material.dart';

class CalculatorButtonGrid extends StatelessWidget {
  final List<String> items;
  final Function(String) onTap;
  final bool isMemories;
  final bool hasMemory;

  const CalculatorButtonGrid(
      {super.key,
      required this.items,
      required this.onTap,
      this.isMemories = false,
      this.hasMemory = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMemories ? 6 : 4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return isMemories
            ? MemoryButton(
                memoryText: items[index],
                onTap: () => onTap(items[index]),
                isMemory: hasMemory,
              )
            : ButtonNumber(
                number: items[index],
                onTap: () {
                  onTap(items[index]);
                },
                buttonColor: getButtonColor(items[index]),
              );
      },
    );
  }
}
