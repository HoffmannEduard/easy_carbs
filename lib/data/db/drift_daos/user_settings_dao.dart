import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/data/db/drift_tables/user_settings_table.dart';

part 'user_settings_dao.g.dart';

// DAO-Klasse für UserSettings, hier werden Datenbankoperationen ausgeführt
@DriftAccessor(tables: [UserSettingsTable])
class UserSettingsDao extends DatabaseAccessor<AppDatabase> with _$UserSettingsDaoMixin {

  UserSettingsDao(super.db);

  Future<UserSettingsTableData?> loadSettings() {
    return select(userSettingsTable).getSingleOrNull();
  }

  Future<void> saveSettings(UserSettingsTableCompanion data) {
    return into(userSettingsTable).insert(data);
  }

  Future<void> updateSettings(UserSettingsTableCompanion fieldsToUpdate) async {
  await (update(userSettingsTable)
        ..where((tbl) => tbl.id.equals('one_and_only'))) // fester Primary Key
      .write(fieldsToUpdate);
}


  Stream<UserSettingsTableData?> watchSettings() => select(userSettingsTable).watchSingleOrNull();
}
