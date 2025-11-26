import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driftDbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});


final mealRepositoryProvider = Provider<IMealRepository>((ref) {
  final dao = MealDao(ref.watch(driftDbProvider));
  return MealRepositoryDrift(dao);
});


final mealsStreamProvider = StreamProvider<List<MealsTableData>>((ref) {
  final dao = MealDao(ref.watch(driftDbProvider));
  return dao.watchAllMeals(); // Stream<List<MealsTableData>>
});