import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

Color getButtonColor (String label) {
  switch (label) {
    case '÷' || '×' || '-' || '+':
    return AppColors.operationsButtonColor;
    case '=':
      return AppColors.equalButtonColor;
    case 'C':
      return AppColors.clearButtonColor;
    default:
      return AppColors.secondaryColor;
  }
}