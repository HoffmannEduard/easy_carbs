import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:flutter/material.dart';

class UserSettingsMapper {
  static UserSettings fromDrift(
    UserSettingsTableData settingsData,
    List<TimeBasedInsulinFactorsTableData> factorRows,
  ) {
    // Map rows -> factors (Start + Factor), End wird unten abgeleitet
    TimeBasedInsulinFactor build(InsulinBlockId id, {required TimeOfDay defaultStart, required double defaultFactor}) {
      final row = factorRows.where((r) => r.id == id.key).cast<TimeBasedInsulinFactorsTableData?>().firstWhere(
            (r) => r != null,
            orElse: () => null,
          );

      final startMin = row?.startTimeMinutes ?? FixedInsulinSchedule.toMin(defaultStart);
      final factor = row?.insulinFactor ?? defaultFactor;

      // endTime wird nach normalize gesetzt
      return TimeBasedInsulinFactor(
        id: id.key,
        startTime: FixedInsulinSchedule.fromMin(startMin),
        endTime: const TimeOfDay(hour: 0, minute: 0),
        insulinFactor: factor,
      );
    }

    final raw = FixedInsulinFactors(
      morning: build(InsulinBlockId.morning, defaultStart: const TimeOfDay(hour: 6, minute: 0), defaultFactor: 1.0),
      midday: build(InsulinBlockId.midday, defaultStart: const TimeOfDay(hour: 12, minute: 0), defaultFactor: 1.0),
      evening: build(InsulinBlockId.evening, defaultStart: const TimeOfDay(hour: 18, minute: 0), defaultFactor: 1.0),
      night: build(InsulinBlockId.night, defaultStart: const TimeOfDay(hour: 22, minute: 0), defaultFactor: 1.0),
    );

    final normalized = FixedInsulinSchedule.normalize(raw);

    return UserSettings(
      id: settingsData.id,
      carbUnit: settingsData.carbUnit,
      insulinFactors: normalized,
      showInsulin: settingsData.showFpe,
      fpeFactor: settingsData.fpeFactor,
    );
  }

  static Map<String, dynamic> toDrift(UserSettings settings) {
    final normalized = FixedInsulinSchedule.normalize(settings.insulinFactors);

    final settingsCompanion = UserSettingsTableCompanion(
      id: Value(settings.id),
      carbUnit: Value(settings.carbUnit),
      showFpe: Value(settings.showInsulin),
      fpeFactor: Value(settings.fpeFactor),
    );

    int startMin(TimeBasedInsulinFactor f) => FixedInsulinSchedule.toMin(f.startTime);
    int endMin(TimeBasedInsulinFactor f) => FixedInsulinSchedule.toMin(f.endTime);

    final factorCompanions = normalized.asList().map((f) {
      return TimeBasedInsulinFactorsTableCompanion(
        userSettingsId: Value(settings.id),
        id: Value(f.id),
        startTimeMinutes: Value(startMin(f)),
        endTimeMinutes: Value(endMin(f)),
        insulinFactor: Value(f.insulinFactor),
      );
    }).toList();

    return {'settings': settingsCompanion, 'factors': factorCompanions};
  }
}
