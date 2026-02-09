import 'package:easy_carbs/domain/usecases/meals/calculate_automatically_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/services/nutrition_calculator.dart';
import 'package:easy_carbs/domain/services/nutrition_portion_scaler.dart';

import '../../../data/repositories/fake_meal_repository.dart';

void main() {
  const scaler = NutritionPortionScaler();
  const calc = NutritionCalculator();

  group('CalculateAutomaticallyUseCase.setCarbsInUnitAndFpe', () {
    test('berechnet carbsInUnit und fpe und persistiert Update wenn autocalculate aktiv ist', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: true,
        nutrition: Nutrition(
          carbs: 24,   // pro 100g
          fat: 10,
          protein: 10,
        ),
        portionsize: 100,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when
      await useCase.setCarbsInUnitAndFpe('m1');

      // then
      expect(repo.updateCalls, 1);
      expect(repo.lastUpdatedMeal, isNotNull);

      // carbs: 24g => 2 BE (12g = 1 BE)
      expect(repo.lastUpdatedMeal!.carbsInUnit, 2.0);

      // fat 10g => 90 kcal, protein 10g => 40 kcal => 130 kcal => 1.3 FPE
      expect(repo.lastUpdatedMeal!.fpe, closeTo(1.3, 0.0001));
    });

    test('persistiert nicht wenn autocalculate deaktiviert ist', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: false,
        nutrition: Nutrition(carbs: 24, fat: 10, protein: 10),
        portionsize: 100,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when
      await useCase.setCarbsInUnitAndFpe('m1');

      // then
      expect(repo.updateCalls, 0);
      expect(repo.lastUpdatedMeal, isNull);
    });

    test('persistiert nicht wenn nutrition fehlt', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: true,
        nutrition: null,
        portionsize: 100,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when
      await useCase.setCarbsInUnitAndFpe('m1');

      // then
      expect(repo.updateCalls, 0);
    });

    test('persistiert nicht wenn portionsize fehlt', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: true,
        nutrition: Nutrition(carbs: 24, fat: 10, protein: 10),
        portionsize: null,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when
      await useCase.setCarbsInUnitAndFpe('m1');

      // then
      expect(repo.updateCalls, 0);
    });

    test('setzt fpe auf null wenn fat oder protein fehlt', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: true,
        nutrition: Nutrition(
          carbs: 24,
          fat: 10,
          protein: null, // fehlt => fpe null
        ),
        portionsize: 100,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when
      await useCase.setCarbsInUnitAndFpe('m1');

      // then
      expect(repo.updateCalls, 1);
      expect(repo.lastUpdatedMeal!.carbsInUnit, 2.0);
      expect(repo.lastUpdatedMeal!.fpe, isNull);
    });

    test('wirft StateError wenn Meal nicht existiert', () async {
      // given
      final repo = FakeMealRepository(initial: null);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when / then
      await expectLater(
        () => useCase.setCarbsInUnitAndFpe('does-not-exist'),
        throwsA(isA<StateError>()),
      );
    });

    test('wirft StateError wenn carbs fehlen aber autocalculate aktiv ist', () async {
      // given
      final meal = Meal(
        id: 'm1',
        name: 'Test',
        carbUnit: CarbUnit.be,
        autocalculate: true,
        nutrition: Nutrition(
          carbs: null, // => darf nicht berechnet werden
          fat: 10,
          protein: 10,
        ),
        portionsize: 100,
        portionUnit: PortionUnit.gramm,
      );

      final repo = FakeMealRepository(initial: meal);
      final useCase = CalculateAutomaticallyUseCase(repo, scaler, calc);

      // when / then
      await expectLater(
        () => useCase.setCarbsInUnitAndFpe('m1'),
        throwsA(isA<StateError>()),
      );
    });
  });
}
