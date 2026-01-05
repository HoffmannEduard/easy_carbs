import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'drift_tables/meals_table.dart';
import 'drift_tables/user_settings_table.dart';
import 'drift_tables/nutritions_table.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/data/db/type_converters/carb_unit_converter.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [MealsTable, NutritionsTable, UserSettingsTable], daos: [MealDao, UserSettingsDao])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  //für Tests
  AppDatabase.forTesting(super.executer);

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