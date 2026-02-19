import 'package:easy_carbs/domain/usecases/meals/calculate_fpe_insulin_units_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:flutter/material.dart';

void main() {
  const useCase = CalculateFpeInsulinUnitsUseCase();

  UserSettings givenSettings({
    required bool showInsulin,
    required double? fpeFactor,
  }) {
    final dummyFactors = FixedInsulinFactors(
      morning: TimeBasedInsulinFactor(
        id: InsulinBlockId.morning.key,
        startTime: const TimeOfDay(hour: 6, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        insulinFactor: 1.0,
      ),
      midday: TimeBasedInsulinFactor(
        id: InsulinBlockId.midday.key,
        startTime: const TimeOfDay(hour: 12, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
        insulinFactor: 1.0,
      ),
      evening: TimeBasedInsulinFactor(
        id: InsulinBlockId.evening.key,
        startTime: const TimeOfDay(hour: 18, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        insulinFactor: 1.0,
      ),
      night: TimeBasedInsulinFactor(
        id: InsulinBlockId.night.key,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
        insulinFactor: 1.0,
      ),
    );

    return UserSettings(
      id: 'user',
      carbUnit: CarbUnit.be,
      insulinFactors: dummyFactors,
      showInsulin: showInsulin,
      fpeFactor: fpeFactor,
    );
  }

  group('CalculateFpeInsulinUnitsUseCase.call', () {

    test('gibt null zurück wenn showInsulin false ist', () {
      // given
      final settings = givenSettings(
        showInsulin: false,
        fpeFactor: 1.2,
      );

      // when
      final result = useCase(
        settings: settings,
        fpe: 1.5,
      );

      // then
      expect(result, isNull);
    });

    test('gibt null zurück wenn fpeFactor null ist', () {
      // given
      final settings = givenSettings(
        showInsulin: true,
        fpeFactor: null,
      );

      // when
      final result = useCase(
        settings: settings,
        fpe: 1.5,
      );

      // then
      expect(result, isNull);
    });

    test('gibt null zurück wenn fpe null ist', () {
      // given
      final settings = givenSettings(
        showInsulin: true,
        fpeFactor: 1.2,
      );

      // when
      final result = useCase(
        settings: settings,
        fpe: null,
      );

      // then
      expect(result, isNull);
    });

    test('berechnet FPE-Insulin korrekt und rundet auf 0.1 IE', () {
      // given
      final settings = givenSettings(
        showInsulin: true,
        fpeFactor: 1.5,
      );

      // when
      final result = useCase(
        settings: settings,
        fpe: 1.23,
      );

      // 1.23 * 1.5 = 1.845 → 1.8
      // then
      expect(result, 1.8);
    });

    test('rundet korrekt bei Grenzwerten', () {
      // given
      final settings = givenSettings(
        showInsulin: true,
        fpeFactor: 2.0,
      );

      // when
      final result = useCase(
        settings: settings,
        fpe: 1.05,
      );

      // 1.05 * 2.0 = 2.1 → bleibt 2.1
      // then
      expect(result, 2.1);
    });
  });
}
