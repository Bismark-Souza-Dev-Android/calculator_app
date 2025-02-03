import 'package:ccapp/feature/calculator/domain/entity/calculator_entities.dart';

class CalculatorModel extends CalculatorEntity {
  CalculatorModel({required double result}) : super(result);

  factory CalculatorModel.fromValues(double result) {
    return CalculatorModel(result: result);
  }
}