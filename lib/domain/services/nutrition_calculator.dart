import 'package:easy_carbs/domain/entities/carb_unit.dart';

class NutritionCalculator {
  const NutritionCalculator();

  double calculateCarbsInUnit({
    required double carbsGramm,
    required CarbUnit unit,
  }) {
    final gramsPerUnit = unit == CarbUnit.be ? 12.0 : 10.0;
    return carbsGramm / gramsPerUnit;
  }

  double calculateFpe({
    required double fatGramm,
    required double proteinGramm,
  }) {
    final kcal = fatGramm * 9.0 + proteinGramm * 4.0;
    return kcal / 100.0;
  }
}