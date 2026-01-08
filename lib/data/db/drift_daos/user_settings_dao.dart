import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import '../drift_tables/user_settings_table.dart';
import '../drift_tables/time_based_insulin_factors_table.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserSettingsTable, TimeBasedInsulinFactorsTable])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {

  UserSettingsDao(super.db);

  static const defaultSettingsId = 'user';

  // ================= INSERT/UPDATE =================
  Future<void> saveSettings(
      UserSettingsTableCompanion settings,
      List<TimeBasedInsulinFactorsTableCompanion> insulinFactors,
      ) async {
    await transaction(() async {
      await into(userSettingsTable).insertOnConflictUpdate(settings);

      // Alte Faktoren löschen
      await (delete(timeBasedInsulinFactorsTable)
        ..where((tbl) => tbl.userSettingsId.equals(settings.id.value)))
        .go();

      // Neue Faktoren einfügen
      for (final factor in insulinFactors) {
        await into(timeBasedInsulinFactorsTable).insert(factor);
      }
    });
  }

  Future<void> addOrUpdateFactor(TimeBasedInsulinFactorsTableCompanion factor) async {
    await into(timeBasedInsulinFactorsTable).insertOnConflictUpdate(factor);
  }

  Future<int> deleteFactor(String factorId) async {
    return await (delete(timeBasedInsulinFactorsTable)
      ..where((tbl) => tbl.id.equals(factorId)))
      .go();
  }

  // ================= SELECT =================
  Future<UserSettingsWithFactors?> getSettings() async {
    final rows = await _selectWithFactors().get();
    if (rows.isEmpty) return null;

    final settings = rows.first.readTable(userSettingsTable);
    final factors = rows
        .map((row) => row.readTableOrNull(timeBasedInsulinFactorsTable))
        .whereType<TimeBasedInsulinFactorsTableData>()
        .toList();

    return UserSettingsWithFactors(
      settings: settings,
      insulinFactors: factors,
    );
  }

  Stream<UserSettingsWithFactors?> watchSettings() {
    return _selectWithFactors().watch().map((rows) {
      if (rows.isEmpty) return null;

      final settings = rows.first.readTable(userSettingsTable);
      final factors = rows
          .map((row) => row.readTableOrNull(timeBasedInsulinFactorsTable))
          .whereType<TimeBasedInsulinFactorsTableData>()
          .toList();

      return UserSettingsWithFactors(
        settings: settings,
        insulinFactors: factors,
      );
    });
  }

  // Hilfsmethode für SELECT mit Join
  JoinedSelectStatement _selectWithFactors() {
    return select(userSettingsTable).join([
      leftOuterJoin(
        timeBasedInsulinFactorsTable,
        timeBasedInsulinFactorsTable.userSettingsId
            .equalsExp(userSettingsTable.id),
      ),
    ])..where(userSettingsTable.id.equals(defaultSettingsId));
  }
}

// ================= Hilfsklasse =================
class UserSettingsWithFactors {
  final UserSettingsTableData settings;
  final List<TimeBasedInsulinFactorsTableData> insulinFactors;

  UserSettingsWithFactors({
    required this.settings,
    required this.insulinFactors,
  });
}
