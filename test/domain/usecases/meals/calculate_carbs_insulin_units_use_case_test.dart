import 'package:easy_carbs/domain/usecases/meals/calculate_carbs_insulin_units_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/services/insulin_factor_resolver.dart';

void main() {
  const resolver = InsulinFactorResolver();
  const useCase = CalculateCarbsInsulinUnitsUseCase(resolver);

  UserSettings givenSettings() {
    final factors = FixedInsulinFactors(
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
        insulinFactor: 1.5,
      ),
      evening: TimeBasedInsulinFactor(
        id: InsulinBlockId.evening.key,
        startTime: const TimeOfDay(hour: 18, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        insulinFactor: 2.0,
      ),
      night: TimeBasedInsulinFactor(
        id: InsulinBlockId.night.key,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
        insulinFactor: 0.5,
      ),
    );

    return UserSettings(
      id: 'user',
      carbUnit: CarbUnit.be,
      insulinFactors: factors,
      showInsulin: true,
      fpeFactor: null,
    );
  }

  group('CalculateCarbsInsulinUnitsUseCase.call', () {

    test('gibt null zurück wenn carbsInUnit null ist', () {
      // given
      final settings = givenSettings();

      // when
      final result = useCase(
        settings: settings,
        carbsInUnit: null,
        now: const TimeOfDay(hour: 8, minute: 0),
      );

      // then
      expect(result, isNull);
    });

    test('berechnet Insulineinheiten mit korrekt aufgelöstem Faktor', () {
      // given
      final settings = givenSettings();

      // when (13:00 => midday => Faktor 1.5)
      final result = useCase(
        settings: settings,
        carbsInUnit: 2.0,
        now: const TimeOfDay(hour: 13, minute: 0),
      );

      // then
      // 2.0 * 1.5 = 3.0
      expect(result, 3.0);
    });

    test('rundet korrekt auf 0.1 IE', () {
      // given
      final settings = givenSettings();

      // when (midday Faktor 1.5)
      final result = useCase(
        settings: settings,
        carbsInUnit: 1.23,
        now: const TimeOfDay(hour: 13, minute: 0),
      );

      // 1.23 * 1.5 = 1.845 → gerundet auf 0.1 = 1.8
      // then
      expect(result, 1.8);
    });

    test('rundet korrekt bei Grenzwert 0.05 aufwärts', () {
      // given
      final settings = givenSettings();

      // when
      final result = useCase(
        settings: settings,
        carbsInUnit: 1.0,
        now: const TimeOfDay(hour: 18, minute: 0), // evening Faktor 2.0
      );

      // 1.0 * 2.0 = 2.0 → bleibt 2.0
      expect(result, 2.0);
    });

    test('verwendet Nachtfaktor bei Zeiten vor morningStart', () {
      // given
      final settings = givenSettings();

      // when (02:00 => night Faktor 0.5)
      final result = useCase(
        settings: settings,
        carbsInUnit: 2.0,
        now: const TimeOfDay(hour: 2, minute: 0),
      );

      // 2.0 * 0.5 = 1.0
      expect(result, 1.0);
    });
  });
}
