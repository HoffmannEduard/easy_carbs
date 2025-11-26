import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';


class UserSettingsMapper {
  static UserSettings fromTable(UserSettingsTableData row) {
    return UserSettings(
      id: row.id,
      carbUnit: row.carbUnit,
      carbFactor: row.carbFactor,
      showFpe: row.showFpe,
      fpeFactor: row.fpeFactor,
      darkMode: row.darkMode,
    );
  }

  static UserSettingsTableCompanion toTable(UserSettings entity) {
    return UserSettingsTableCompanion(
      id: Value(entity.id),
      carbUnit: Value(entity.carbUnit),
      carbFactor: Value(entity.carbFactor),
      showFpe: Value(entity.showFpe),
      fpeFactor: Value(entity.fpeFactor),
      darkMode: Value(entity.darkMode),
    );
  }
}
