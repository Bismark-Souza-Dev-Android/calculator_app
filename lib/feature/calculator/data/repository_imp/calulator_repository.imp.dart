import 'package:ccapp/feature/calculator/domain/repository/calulator_repository.dart';

abstract class CalculatorRepositoryImp implements CalculatorRepository {
  @override
  Future<double> add(double a, double b) async => a + b;
  @override
  Future<double> subtract(double a, double b) async => a - b;
  @override
  Future<double> multiply(double a, double b) async => a * b;
  @override
  Future<double> divide(double a, double b) async {
   if (b==0) {
     throw Exception('Não pode dividir por zero');
   }
   return a / b;
  }
}