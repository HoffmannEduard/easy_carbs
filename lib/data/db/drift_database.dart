
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'drift_tables/meals_table.dart';
import 'package:uuid/uuid.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [MealsTable], daos: [MealDao])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/easy_carbs.sqlite');
    return NativeDatabase(file);
  });
}