import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';

void main() {
  group('FixedInsulinSchedule - Kernfunktionalität', () {

    test('normalize erzwingt minGap und setzt Endzeiten korrekt inkl. wrap', () {
      final factors = FixedInsulinFactors(
        morning: TimeBasedInsulinFactor(
          id: 'morning',
          startTime: TimeOfDay(hour: 6, minute: 0),
          endTime: TimeOfDay(hour: 12, minute: 0),
          insulinFactor: 1.0,
        ),
        midday: TimeBasedInsulinFactor(
          id: 'midday',
          startTime: TimeOfDay(hour: 6, minute: 2), // zu nah
          endTime: TimeOfDay(hour: 18, minute: 0),
          insulinFactor: 1.0,
        ),
        evening: TimeBasedInsulinFactor(
          id: 'evening',
          startTime: TimeOfDay(hour: 6, minute: 3), // zu nah
          endTime: TimeOfDay(hour: 22, minute: 0),
          insulinFactor: 1.0,
        ),
        night: TimeBasedInsulinFactor(
          id: 'night',
          startTime: TimeOfDay(hour: 6, minute: 4), // zu nah
          endTime: TimeOfDay(hour: 6, minute: 0),
          insulinFactor: 1.0,
        ),
      );

      final normalized = FixedInsulinSchedule.normalize(factors);

      final m = FixedInsulinSchedule.toMin(normalized.morning.startTime);
      final d = FixedInsulinSchedule.toMin(normalized.midday.startTime);
      final e = FixedInsulinSchedule.toMin(normalized.evening.startTime);
      final n = FixedInsulinSchedule.toMin(normalized.night.startTime);

      expect(d - m, greaterThanOrEqualTo(FixedInsulinSchedule.minGap));
      expect(e - d, greaterThanOrEqualTo(FixedInsulinSchedule.minGap));
      expect(n - e, greaterThanOrEqualTo(FixedInsulinSchedule.minGap));

      // Endzeiten = Startzeit des nächsten Blocks
      expect(normalized.morning.endTime, normalized.midday.startTime);
      expect(normalized.midday.endTime, normalized.evening.startTime);
      expect(normalized.evening.endTime, normalized.night.startTime);
      expect(normalized.night.endTime, normalized.morning.startTime); // wrap
    });

    test('setEnd setzt Startzeit des nächsten Blocks korrekt (morning → midday)', () {
      final base = FixedInsulinSchedule.defaults();

      final updated = FixedInsulinSchedule.setEnd(
        base,
        InsulinBlockId.morning,
        const TimeOfDay(hour: 13, minute: 0),
      );

      expect(updated.midday.startTime, const TimeOfDay(hour: 13, minute: 0));
      expect(updated.morning.endTime, updated.midday.startTime);

      // Kette bleibt konsistent
      expect(updated.midday.endTime, updated.evening.startTime);
      expect(updated.evening.endTime, updated.night.startTime);
      expect(updated.night.endTime, updated.morning.startTime);
    });

    test('displayEndInclusive: 00:00 ergibt 23:59 (wrap korrekt)', () {
      final result = FixedInsulinSchedule.displayEndInclusive(
        const TimeOfDay(hour: 0, minute: 0),
      );

      expect(result, const TimeOfDay(hour: 23, minute: 59));
    });
  });
}
