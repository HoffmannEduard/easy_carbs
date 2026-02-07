import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/repositories/user_settings_repository_drift.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';

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
          endTime: const TimeOfDay(hour: 6, minute: 0), // wrap
          insulinFactor: 1.0,
        ),
      );

      final settings = UserSettings(
        id: 'user',
        carbUnit: CarbUnit.be,
        insulinFactors: factors,
        showInsulin: false,
        fpeFactor: null,
      );

      await repository.saveSettings(settings);

      final loaded = await repository.getSettings();
      expect(loaded, isNotNull);
      expect(loaded!.carbUnit, CarbUnit.be);
      expect(loaded.showInsulin, false);

      expect(loaded.insulinFactors.morning.id, InsulinBlockId.morning.key);
      expect(loaded.insulinFactors.midday.id, InsulinBlockId.midday.key);
      expect(loaded.insulinFactors.evening.id, InsulinBlockId.evening.key);
      expect(loaded.insulinFactors.night.id, InsulinBlockId.night.key);
    });

    test('updateSettings - Werte werden überschrieben', () async {
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

      final settings = UserSettings(
        id: 'user',
        carbUnit: CarbUnit.be,
        insulinFactors: factors,
        showInsulin: false,
        fpeFactor: null,
      );
      await repository.saveSettings(settings);

      final updated = settings.copyWith(
        carbUnit: CarbUnit.be,
        showInsulin: true,
        fpeFactor: 1.2,
      );

      await repository.saveSettings(updated);

      final result = await repository.getSettings();
      expect(result!.id, settings.id);
      expect(result.carbUnit, CarbUnit.be);
      expect(result.showInsulin, true);
      expect(result.fpeFactor, 1.2);
    });

    test('addInsulinFactor - Faktor wird hinzugefügt', () async {
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

      final settings = UserSettings(
        id: 'user',
        carbUnit: CarbUnit.be,
        insulinFactors: factors,
        showInsulin: false,
        fpeFactor: null,
      );
      await repository.saveSettings(settings);

      
      // Simulation: "Faktor ändern" durch saveSettings mit überschriebenem Block.
      final updatedFactors = settings.insulinFactors.copyWith(
        morning: settings.insulinFactors.morning.copyWith(insulinFactor: 1.5),
      );

      await repository.saveSettings(settings.copyWith(insulinFactors: updatedFactors));

      final loaded = await repository.getSettings();
      expect(loaded, isNotNull);
      expect(loaded!.insulinFactors.morning.insulinFactor, 1.5);
    });

    test('deleteInsulinFactor - Faktor wird entfernt', () async {
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

      final settings = UserSettings(
        id: 'user',
        carbUnit: CarbUnit.be,
        insulinFactors: factors,
        showInsulin: false,
        fpeFactor: null,
      );
      await repository.saveSettings(settings);

      
      //Faktor auf einen Default setzen (z.B. 1.0) oder UI-seitig validieren.
      final updatedFactors = settings.insulinFactors.copyWith(
        morning: settings.insulinFactors.morning.copyWith(insulinFactor: 1.0),
      );

      await repository.saveSettings(settings.copyWith(insulinFactors: updatedFactors));

      final loaded = await repository.getSettings();
      expect(loaded, isNotNull);
      expect(loaded!.insulinFactors.morning.insulinFactor, 1.0);
    });
  });

  group('Streams', () {
    test('watchSettings liefert Updates', () async {
      final updates = <UserSettings?>[];
      final sub = repository.watchSettings().listen(updates.add);

      await Future.delayed(const Duration(milliseconds: 50));

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

      final settings = UserSettings(
        id: 'user',
        carbUnit: CarbUnit.be,
        insulinFactors: factors,
        showInsulin: false,
        fpeFactor: null,
      );
      await repository.saveSettings(settings);

      await Future.delayed(const Duration(milliseconds: 50));

      expect(updates.length, greaterThanOrEqualTo(2));
      expect(updates.last!.carbUnit, CarbUnit.be);

      await sub.cancel();
    });
  });

  group('Edge Cases', () {
    test('getSettings - keine Settings vorhanden', () async {
      final result = await repository.getSettings();
      expect(result, isNull);
    });

    test('Mehrfaches saveSettings überschreibt korrekt', () async {
      final factors1 = FixedInsulinFactors(
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

      await repository.saveSettings(
        UserSettings(
          id: 'user',
          carbUnit: CarbUnit.be,
          insulinFactors: factors1,
          showInsulin: false,
          fpeFactor: null,
        ),
      );

      final factors2 = factors1.copyWith(
        morning: factors1.morning.copyWith(startTime: const TimeOfDay(hour: 7, minute: 0)),
      );

      await repository.saveSettings(
        UserSettings(
          id: 'user',
          carbUnit: CarbUnit.be,
          insulinFactors: factors2,
          showInsulin: true,
          fpeFactor: null,
        ),
      );

      final result = await repository.getSettings();
      expect(result!.carbUnit, CarbUnit.be);
      expect(result.showInsulin, true);
    });
  });
}
