import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/services/nutrition_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = NutritionCalculator();

  group('calculateCarbUnits', () {
    test('berechnet BE korrekt (12g KH = 1 BE)', () {
      final result = calculator.calculateCarbsInUnit(
        carbsGramm: 24.0,
        unit: CarbUnit.be,
      );

      expect(result, 2.0);
    });

    test('berechnet KE korrekt (10g KH = 1 KE)', () {
      final result = calculator.calculateCarbsInUnit(
        carbsGramm: 30.0,
        unit: CarbUnit.ke,
      );

      expect(result, 3.0);
    });
  });

  group('calculateFpe', () {
    test('berechnet FPE korrekt nach kcal/100', () {
      // fat: 10g → 90 kcal
      // protein: 10g → 40 kcal
      // total: 130 kcal → 1.3 FPE
      final result = calculator.calculateFpe(
        fatGramm: 10.0,
        proteinGramm: 10.0,
      );

      expect(result, closeTo(1.3, 0.0001));
    });
  });
}
