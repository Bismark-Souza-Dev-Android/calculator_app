import 'package:ccapp/core/app_colors.dart';
import 'package:flutter/material.dart';

Color getButtonColor(String label) {
  switch (label) {
    case '÷' || '×' || '-' || '+':
      return AppColors.gradientFinalFieldColor;
    case '%' || 'CE' || '<=' || '¹/x' || 'x²' || '²√x' || '+/-' || ',':
      return AppColors.operationsButtonColor;
    case '=':
      return AppColors.equalButtonColor;
    case 'C':
      return AppColors.clearButtonColor;
    default:
      return AppColors.buttonGreenColor;
  }
}

Color getTextColor(String label) {
  switch (label) {
    case '÷' || '×' || '-' || '+' || '%' || 'CE' || '<=' || 'C' || '¹/x' ||
          'x²' || '²√x' || '+/-' || ',':
      return AppColors.fontColor;
    case '=':
      return AppColors.blackColor;
    default:
      return AppColors.blackColor;
  }
}
