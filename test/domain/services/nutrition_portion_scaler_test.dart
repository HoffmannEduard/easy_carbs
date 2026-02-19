import 'package:flutter_test/flutter_test.dart';

import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/domain/services/nutrition_portion_scaler.dart';

void main() {
  const scaler = NutritionPortionScaler();

  group('NutritionPortionScaler.scale', () {

    test('skalieren mit PortionUnit.portion multipliziert Werte korrekt', () {
      // given
      final nutrition = Nutrition(
        carbs: 10,
        fat: 5,
        protein: 8,
      );

      // when
      final result = scaler.scale(
        nutrition: nutrition,
        unit: PortionUnit.portion,
        portionSize: 2,
      );

      // then
      expect(result.carbs, 20);
      expect(result.fat, 10);
      expect(result.protein, 16);
    });

    test('skalieren mit PortionUnit.gramm berechnet Faktor portionSize/100 korrekt', () {
      // given
      final nutrition = Nutrition(
        carbs: 12,   // pro 100g
        fat: 10,
        protein: 8,
      );

      // when
      final result = scaler.scale(
        nutrition: nutrition,
        unit: PortionUnit.gramm,
        portionSize: 250, // 2.5 * 100g
      );

      // then
      expect(result.carbs, 12 * 2.5);
      expect(result.fat, 10 * 2.5);
      expect(result.protein, 8 * 2.5);
    });

    test('skalieren mit PortionUnit.piece nutzt weightOnePiece korrekt', () {
      // given
      final nutrition = Nutrition(
        carbs: 10,   // pro 100g
        fat: 4,
        protein: 6,
        weightOnePiece: 80, // 80g pro Stück
      );

      // when
      final result = scaler.scale(
        nutrition: nutrition,
        unit: PortionUnit.piece,
        portionSize: 3, // 240g => Faktor 2.4
      );

      // then
      expect(result.carbs, 10 * 2.4);
      expect(result.fat, 4 * 2.4);
      expect(result.protein, 6 * 2.4);
    });

    test('null-Werte bleiben beim Skalieren null', () {
      // given
      final nutrition = Nutrition(
        carbs: null,
        fat: 10,
        protein: null,
        weightOnePiece: 50,
      );

      // when
      final result = scaler.scale(
        nutrition: nutrition,
        unit: PortionUnit.piece,
        portionSize: 2, // 100g => Faktor 1.0
      );

      // then
      expect(result.carbs, isNull);
      expect(result.fat, 10);
      expect(result.protein, isNull);
    });

    test('negative Portionsgröße wirft StateError', () {
      // given
      final nutrition = Nutrition(
        carbs: 10,
        fat: 5,
        protein: 8,
      );

      // when / then
      expect(
        () => scaler.scale(
          nutrition: nutrition,
          unit: PortionUnit.gramm,
          portionSize: -1,
        ),
        throwsA(isA<StateError>()),
      );
    });
  });
}
