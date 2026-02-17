import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import '../drift_tables/user_settings_table.dart';
import '../drift_tables/time_based_insulin_factors_table.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserSettingsTable, TimeBasedInsulinFactorsTable])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {

  UserSettingsDao(super.db);

  /// Feste ID für den einzigen Settings-Datensatz der App.
  static const defaultSettingsId = 'user';

  // ================= INSERT/UPDATE =================
  /// Speichert Einstellungen und ersetzt zugehörige Insulinfaktoren atomar.
  /// Wird innerhalb einer Transaktion ausgeführt.
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

  /// Fügt einen einzelnen Insulinfaktor ein oder aktualisiert ihn.
  Future<void> addOrUpdateFactor(TimeBasedInsulinFactorsTableCompanion factor) async {
    await into(timeBasedInsulinFactorsTable).insertOnConflictUpdate(factor);
  }

  /// Löscht einen Insulinfaktor anhand seiner ID.
  Future<int> deleteFactor(String factorId) async {
    return await (delete(timeBasedInsulinFactorsTable)
      ..where((tbl) => tbl.id.equals(factorId)))
      .go();
  }

  // ================= SELECT =================
  /// Lädt Einstellungen inklusive aller zugehörigen Insulinfaktoren.
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

  /// Beobachtet Einstellungen inklusive Insulinfaktoren als Stream.
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
