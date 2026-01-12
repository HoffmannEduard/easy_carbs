// CRUD-Operationen werden über DAO-Klasse ausgeführt, Datenbank wird injiziert
import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealDaoProvider = Provider<MealDao>((ref) {
  final db = ref.watch(driftDbProvider);
  return MealDao(db);
});

// Verbindung des IRepo mit der konkreten Implementierung (MealRepositoryDrift) und der CRUD-Operationen über DAO
final mealRepositoryProvider = Provider<IMealRepository>((ref) {
  final dao = ref.watch(mealDaoProvider); 
  return MealRepositoryDrift(dao);
});

