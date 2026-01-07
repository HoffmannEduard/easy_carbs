import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:flutter/material.dart';

class UserSettingsMapper {
  static UserSettings fromDrift(
      UserSettingsTableData settingsData,
      List<TimeBasedInsulinFactorsTableData> factorRows,
      ) {
    return UserSettings(
      id: settingsData.id,
      carbUnit: settingsData.carbUnit, // CarbUnit wird bereits konvertiert via Converter
      insulinFactors: factorRows.map((row) => TimeBasedInsulinFactor(
        id: row.id,
        startTime: TimeOfDay(hour: row.startTimeMinutes ~/ 60, minute: row.startTimeMinutes % 60),
        endTime: TimeOfDay(hour: row.endTimeMinutes ~/ 60, minute: row.endTimeMinutes % 60),
        insulinFactor: row.insulinFactor,
      )).toList(),
      showFpe: settingsData.showFpe,
      fpeFactor: settingsData.fpeFactor,
    );
  }

  static Map<String, dynamic> toDrift(UserSettings settings) {
    final settingsCompanion = UserSettingsTableCompanion(
      id: Value(settings.id),
      carbUnit: Value(settings.carbUnit),
      showFpe: Value(settings.showFpe),
      fpeFactor: Value(settings.fpeFactor),
    );

    final factorCompanions = settings.insulinFactors.map((factor) =>
        TimeBasedInsulinFactorsTableCompanion(
          id: Value(factor.id),
          userSettingsId: Value(settings.id),
          startTimeMinutes: Value(factor.startTime.hour * 60 + factor.startTime.minute),
          endTimeMinutes: Value(factor.endTime.hour * 60 + factor.endTime.minute),
          insulinFactor: Value(factor.insulinFactor),
        )
    ).toList();

    return {
      'settings': settingsCompanion,
      'factors': factorCompanions,
    };
  }
}
