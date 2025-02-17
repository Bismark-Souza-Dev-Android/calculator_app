import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

class MemoryButton extends StatefulWidget {
  final String memoryText;
  final void Function() onTap;
  final bool isEnabled;

  const MemoryButton({
    super.key,
    required this.memoryText,
    required this.onTap,
    this.isEnabled = true,
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
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      _isColor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled
          ? () {
              _onTapPress();
              widget.onTap();
            }
          : null,
      child: Container(
          decoration: BoxDecoration(
            color: _isColor
                ? AppColors.secondaryColor
                : (widget.isEnabled
                    ? AppColors.blackColor
                    : AppColors.blackColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
              child: widget.memoryText == '<='
                  ? Icon(
                      Icons.backspace,
                      size: 40,
                      color: Colors.red,
                    )
                  : Text(widget.memoryText,
                      style: TextStyle(
                          fontSize: 20,
                          color: widget.isEnabled
                              ? AppColors.equalButtonColor
                              : AppColors.primaryColor)))),
    );
  }
}
