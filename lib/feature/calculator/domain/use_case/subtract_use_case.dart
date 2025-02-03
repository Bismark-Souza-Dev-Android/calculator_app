import 'package:ccapp/feature/calculator/domain/repository/calulator_repository.dart';

abstract class SubtractUseCase {
  Future<double> execute(double a, double b);
}

class SubtractUseCaseImp implements SubtractUseCase {
  final CalculatorRepository calculatorRepository;

  SubtractUseCaseImp (this.calculatorRepository);

  @override
  Future<double> execute (a, b) async {
    return await calculatorRepository.divide(a, b);
  }
}