import 'package:drift/drift.dart';
import 'nutritions_table.dart';

/// Database Tabelle für Mahlzeiten -> erstellt die Tabelle in der Datenbank (Drift)
/// Erstellt auch die MealsTableData und MealsTableCompanion Klassen

class MealsTable extends Table {
  TextColumn get id => text()();
  TextColumn get carbUnit => text()(); //Speichert Enum als String
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  BoolColumn get autocalculate => boolean()();
  RealColumn get carbsInUnit => real().nullable()();
  RealColumn get fpe => real().nullable()();
  
  // Foreign Key zu Nutritions
  TextColumn get nutritionId => text().nullable().references(NutritionsTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get location => text().nullable()();
  RealColumn get portionsize => real().nullable()();
  TextColumn get portionUnit => text().nullable()(); // Speichert Enum als String
  TextColumn get note => text().nullable()();
  TextColumn get categories => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}