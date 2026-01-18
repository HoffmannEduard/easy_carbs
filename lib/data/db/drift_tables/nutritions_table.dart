import 'package:drift/drift.dart';

// Database Tabelle für Nährwerte -> erstellt die Tabelle in der Datenbank (Drift)
// Erstellt auch die NutritionsTableData und NutritionsTableCompanion Klassen

class NutritionsTable extends Table {
  TextColumn get id => text()();
  RealColumn get carbs => real().nullable()();
  RealColumn get sugar => real().nullable()();
  RealColumn get fat => real().nullable()();
  RealColumn get saturatedFat => real().nullable()();
  RealColumn get protein => real().nullable()();
  RealColumn get weightOnePiece => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}