import 'package:ccapp/feature/calculator/domain/repository/calulator_repository.dart';

abstract class AddUseCase {
  Future<double> execute(double a, double b);
}

class AddUseCaseImp implements AddUseCase {
  late final CalculatorRepository calculatorRepository;

  AddUseCaseImp(this.calculatorRepository);

  @override
  Future<double> execute(double a, double b) async {
    return await calculatorRepository.add(a, b);
  }}