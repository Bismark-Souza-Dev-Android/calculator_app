import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

class MemoryButton extends StatefulWidget {
  final String memoryText;
  final void Function() onTap;
  final bool isMemory;

  const MemoryButton({
    super.key,
    required this.memoryText,
    required this.onTap,
    required this.isMemory,
  });

  @override
  State<MemoryButton> createState() => _MemoryButtonState();
}

class _MemoryButtonState extends State<MemoryButton> {
  bool _isColor = false;

  Future<void> _onTapPress() async {
    setState(() {
      _isColor = true;
    });
    await Future.delayed(Duration(milliseconds: 80));
    setState(() {
      _isColor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _onTapPress();
          widget.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              color: _isColor ? AppColors.secondaryColor : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: widget.isMemory
                  ? Text(
                      widget.memoryText,
                      style: TextStyle(fontSize: 20, color: AppColors.fontColor),
                    )
                  : Text(
                      widget.memoryText,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.memoryTextUnselectedColor),
                    )),
        ));
  }
}
