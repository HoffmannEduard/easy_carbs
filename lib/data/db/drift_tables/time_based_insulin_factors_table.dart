import 'package:drift/drift.dart';

/// Drift-Tabelle für zeitabhängige Insulinfaktoren.
/// Speichert die vier Tagesblöcke (morning, midday, evening, night)
/// je Benutzer-Einstellung (`userSettingsId`).
/// Start- und Endzeiten werden in Minuten seit Mitternacht (0–1439) gespeichert.
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
