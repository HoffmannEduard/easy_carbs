import 'package:drift/drift.dart';

class TimeBasedInsulinFactorsTable extends Table {
  TextColumn get id => text()(); // PK
  TextColumn get userSettingsId => text()(); // FK auf UserSettings.id
  IntColumn get startTimeMinutes => integer()();
  IntColumn get endTimeMinutes => integer()();
  RealColumn get insulinFactor => real()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(user_settings_id) REFERENCES user_settings(id) ON DELETE CASCADE'
      ];
}

