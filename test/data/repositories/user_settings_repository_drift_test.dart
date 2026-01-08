import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/repositories/user_settings_repository_drift.dart';

import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';

void main() {
  late AppDatabase database;
  late UserSettingsRepositoryDrift repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    final dao = UserSettingsDao(database);
    repository = UserSettingsRepositoryDrift(dao);
  });

  tearDown(() async {
    await database.close();
  });

  group('UserSettingsRepository CRUD Operations', () {
    
    test('saveSettings & getSettings - Basis UserSettings speichern', () async {
      final settings = UserSettings(
        carbUnit: CarbUnit.gramm,
        insulinFactors: [],
        showFpe: false,
      );

      await repository.saveSettings(settings);

      final loaded = await repository.getSettings();
      expect(loaded, isNotNull);
      expect(loaded!.carbUnit, CarbUnit.gramm);
      expect(loaded.showFpe, false);
      expect(loaded.insulinFactors, isEmpty);
    });

    test('updateSettings - Werte werden überschrieben', () async {
      final settings = UserSettings(
        carbUnit: CarbUnit.gramm,
        insulinFactors: [],
        showFpe: false,
      );
      await repository.saveSettings(settings);

      final updated = settings.copyWith(
        carbUnit: CarbUnit.be,
        showFpe: true,
        fpeFactor: 1.2,
      );

      await repository.saveSettings(updated);

      final result = await repository.getSettings();
      expect(result!.id, settings.id);
      expect(result.carbUnit, CarbUnit.be);
      expect(result.showFpe, true);
      expect(result.fpeFactor, 1.2);
    });

    test('addInsulinFactor - Faktor wird hinzugefügt', () async {
      final settings = UserSettings(
        carbUnit: CarbUnit.gramm,
        insulinFactors: [],
        showFpe: false,
      );
      await repository.saveSettings(settings);

      final factor = TimeBasedInsulinFactor(
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        insulinFactor: 1.5,
      );

      await repository.addInsulinFactor(factor);

      final loaded = await repository.getSettings();
      expect(loaded!.insulinFactors.length, 1);
      expect(loaded.insulinFactors.first.insulinFactor, 1.5);
    });

    test('deleteInsulinFactor - Faktor wird entfernt', () async {
      final factor = TimeBasedInsulinFactor(
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        insulinFactor: 1.5,
      );

      final settings = UserSettings(
        carbUnit: CarbUnit.gramm,
        insulinFactors: [factor],
        showFpe: false,
      );
      await repository.saveSettings(settings);

      await repository.deleteInsulinFactor(factor.id);

      final loaded = await repository.getSettings();
      expect(loaded!.insulinFactors, isEmpty);
    });
  });

  group('Streams', () {

    test('watchSettings liefert Updates', () async {
      final updates = <UserSettings?>[];
      final sub = repository.watchSettings().listen(updates.add);

      await Future.delayed(const Duration(milliseconds: 50));

      final settings = UserSettings(
        carbUnit: CarbUnit.gramm,
        insulinFactors: [],
        showFpe: false,
      );
      await repository.saveSettings(settings);

      await Future.delayed(const Duration(milliseconds: 50));

      expect(updates.length, greaterThanOrEqualTo(2));
      expect(updates.last!.carbUnit, CarbUnit.gramm);

      await sub.cancel();
    });
  });

  group('Edge Cases', () {

    test('getSettings - keine Settings vorhanden', () async {
      final result = await repository.getSettings();
      expect(result, isNull);
    });

    test('Mehrfaches saveSettings überschreibt korrekt', () async {
      await repository.saveSettings(
        UserSettings(
          carbUnit: CarbUnit.gramm,
          insulinFactors: [],
          showFpe: false,
        ),
      );

      await repository.saveSettings(
        UserSettings(
          carbUnit: CarbUnit.be,
          insulinFactors: [],
          showFpe: true,
        ),
      );

      final result = await repository.getSettings();
      expect(result!.carbUnit, CarbUnit.be);
      expect(result.showFpe, true);
    });
  });
}
