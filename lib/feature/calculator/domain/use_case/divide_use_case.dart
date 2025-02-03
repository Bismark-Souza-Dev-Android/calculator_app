import 'package:ccapp/feature/calculator/domain/repository/calulator_repository.dart';

abstract class DivideUseCase {
  Future<double> execute(double a, double b);
}

class DivideUseCaseImp implements DivideUseCase {
  final CalculatorRepository calculatorRepository;

  DivideUseCaseImp (this.calculatorRepository);

  @override
  Future<double> execute (a, b) async {
    return await calculatorRepository.divide(a, b);
  }
}