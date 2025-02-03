import 'package:ccapp/feature/calculator/domain/repository/calulator_repository.dart';

abstract class MultiplyUseCase {
  Future<double> execute(double a, double b);
}

class MultiplyUseCaseImp implements MultiplyUseCase {
  final CalculatorRepository calculatorRepository;

  MultiplyUseCaseImp (this.calculatorRepository);

  @override
  Future<double> execute(a, b) async {
    return await calculatorRepository.multiply(a, b);
  }
}