import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/services/insulin_factor_resolver.dart';

void main() {
  const resolver = InsulinFactorResolver();

  FixedInsulinFactors makeFactors() => FixedInsulinFactors(
        morning: TimeBasedInsulinFactor(
          id: InsulinBlockId.morning.key,
          startTime: const TimeOfDay(hour: 6, minute: 0),
          endTime: const TimeOfDay(hour: 12, minute: 0),
          insulinFactor: 1.1,
        ),
        midday: TimeBasedInsulinFactor(
          id: InsulinBlockId.midday.key,
          startTime: const TimeOfDay(hour: 12, minute: 0),
          endTime: const TimeOfDay(hour: 18, minute: 0),
          insulinFactor: 1.2,
        ),
        evening: TimeBasedInsulinFactor(
          id: InsulinBlockId.evening.key,
          startTime: const TimeOfDay(hour: 18, minute: 0),
          endTime: const TimeOfDay(hour: 22, minute: 0),
          insulinFactor: 1.3,
        ),
        night: TimeBasedInsulinFactor(
          id: InsulinBlockId.night.key,
          startTime: const TimeOfDay(hour: 22, minute: 0),
          endTime: const TimeOfDay(hour: 6, minute: 0),
          insulinFactor: 1.4,
        ),
      );

  group('InsulinFactorResolver.factorForTime', () {
    test('liefert richtigen Faktor innerhalb der Blöcke', () {
      final factors = makeFactors();

      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 7, minute: 0)), 1.1);  // morning
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 13, minute: 0)), 1.2); // midday
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 19, minute: 0)), 1.3); // evening
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 23, minute: 0)), 1.4); // night
    });

    test('Grenzen sind [start, nextStart): Startzeit gehört zum neuen Block', () {
      final factors = makeFactors();

      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 6, minute: 0)), 1.1);  // morning start
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 12, minute: 0)), 1.2); // midday start
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 18, minute: 0)), 1.3); // evening start
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 22, minute: 0)), 1.4); // night start
    });

    test('Wrap-around: Zeiten vor morningStart gehören zur Nacht', () {
      final factors = makeFactors();

      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 2, minute: 0)), 1.4);
      expect(resolver.factorForTime(factors, const TimeOfDay(hour: 5, minute: 59)), 1.4);
    });
  });
}
