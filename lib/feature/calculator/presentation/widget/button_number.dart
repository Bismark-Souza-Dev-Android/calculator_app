import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonNumber extends StatefulWidget {
  final String number;
  final void Function() onTap;
  final Color buttonColor;

  const ButtonNumber({
    super.key,
    required this.number,
    required this.onTap,
    required this.buttonColor,
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
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            widget.number,
            style: TextStyle(fontSize: 20, color: AppColors.fontColor),
          )),
        ));
  }
}
