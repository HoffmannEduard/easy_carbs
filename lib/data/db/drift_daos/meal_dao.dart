import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import '../drift_tables/meals_table.dart';

part 'meal_dao.g.dart';

//DAO Klasse für Mahlzeiten
@DriftAccessor(tables: [MealsTable])
class MealDao extends DatabaseAccessor<AppDatabase> with _$MealDaoMixin {

  MealDao(super.db);

  //CRUD Methoden hier:
  
  Future<int> insertMealCompanion(MealsTableCompanion meal) {
    return into(mealsTable).insert(meal);
  }

  Future<int> deleteMealById(String id) {
    return (delete(mealsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<MealsTableData>> watchAllMeals() => select(mealsTable).watch();

  
}