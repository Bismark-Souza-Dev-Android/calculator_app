import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonNumber extends StatefulWidget {
  final String number;
  final void Function() onTap;
  final Color buttonColor;
  final Color textColor;
  final IconData? icon;

  const ButtonNumber({
    super.key,
    required this.number,
    required this.onTap,
    required this.buttonColor,
    required this.textColor, this.icon,
  });

  @override
  State<ButtonNumber> createState() => _ButtonNumberState();
}

class _ButtonNumberState extends State<ButtonNumber> {
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
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: _isColor ? AppColors.secondaryColor : widget.buttonColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: widget.icon != null ? Icon(widget.icon, size: 30, color: widget.textColor,) : Text(
            widget.number,
            style: TextStyle(fontSize: 30, color: widget.textColor),
          )),
        ));
  }
}
