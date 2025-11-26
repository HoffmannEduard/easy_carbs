import 'package:drift/drift.dart';


//Database Tabelle für Mahlzeiten -> erstellt die Tabelle in der Datenbank (Drift)
//Erstellt auch die MealsTableData und MealsTableCompanion Klassen

class MealsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  RealColumn get carbs => real()();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();

  RealColumn get fat => real().nullable()();
  RealColumn get protein => real().nullable()();
  TextColumn get location => text().nullable()();
  RealColumn get quantity => real().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get categories => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}