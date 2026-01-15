// CRUD-Operationen werden über DAO-Klasse ausgeführt, Datenbank wird injiziert
import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/meal_commands_service.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
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


// Abgeleiteter Provider für Meal-Detail Ansicht
final mealByIdProvider =
    Provider.family<AsyncValue<Meal>, String>((ref, mealId) {
  final mealsAsync = ref.watch(mealListNotifierProvider);

  return mealsAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (meals) {
      final meal = meals.where((m) => m.id == mealId).firstOrNull;

      if (meal == null) {
        // Meal noch nicht im Stream → weiter loading
        return const AsyncValue.loading();
      }

      return AsyncValue.data(meal);
    },
  );
});


// MealCommandsProvider updated Meals über Repo,
// Änderungen über Stream zurückgegeben
final mealCommandsProvider =
    Provider.family<MealCommandsService, String>((ref, mealId) {
  final repo = ref.read(mealRepositoryProvider);
  return MealCommandsService(ref, repo, mealId);
});
