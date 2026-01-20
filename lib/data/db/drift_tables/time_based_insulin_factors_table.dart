import 'package:drift/drift.dart';

class TimeBasedInsulinFactorsTable extends Table {
  TextColumn get userSettingsId => text()();
  TextColumn get id => text()(); // 'morning'|'midday'|'evening'|'night'
  IntColumn get startTimeMinutes => integer()();
  IntColumn get endTimeMinutes => integer()(); // derived
  RealColumn get insulinFactor => real()();

  @override
  Set<Column> get primaryKey => {userSettingsId, id};

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY(user_settings_id) REFERENCES user_settings(id) ON DELETE CASCADE'
      ];
}
