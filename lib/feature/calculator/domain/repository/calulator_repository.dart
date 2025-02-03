abstract class CalculatorRepository {
  Future<double> add(double a, double b);
  Future<double> subtract(double a, double b);
  Future<double> multiply(double a, double b);
  Future<double> divide(double a, double b);
}