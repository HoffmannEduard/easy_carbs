// CRUD-Operationen werden über DAO-Klasse ausgeführt, Datenbank wird injiziert
import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/nutrition_calculator.dart';
import 'package:easy_carbs/domain/services/nutrition_portion_scaler.dart';
import 'package:easy_carbs/domain/usecases/meals/calculate_automatically_use_case.dart';
import 'package:easy_carbs/domain/usecases/meals/meal_commands_use_case.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

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

//Anzahl der Meals
final mealCountAsyncProvider = Provider<AsyncValue<int>>((ref) {
  final mealsAsync = ref.watch(mealListNotifierProvider);
  return mealsAsync.whenData((meals) => meals.length);
});



// MealCommandsProvider updated Meals über Repo,
// Änderungen über Stream zurückgegeben
final mealCommandsProvider =
    Provider.family<MealCommandsUseCase, String>((ref, mealId) {
  final repo = ref.watch(mealRepositoryProvider);
  return MealCommandsUseCase(ref, repo, mealId);
});


final nutritionCalculatorProvider = Provider<NutritionCalculator>((ref) {
  return const NutritionCalculator();
});

final nutritionPortionScalerProvider = Provider<NutritionPortionScaler>((ref) {
  return const NutritionPortionScaler();
});

final calculateAutomaticallyUseCaseProvider =
    Provider<CalculateAutomaticallyUseCase>((ref) {
  final repo = ref.watch(mealRepositoryProvider);
  final calc = ref.watch(nutritionCalculatorProvider);
  final scaler = ref.watch(nutritionPortionScalerProvider);
  return CalculateAutomaticallyUseCase(repo, scaler, calc);
});

// Zuletzt angesehnes Meal
final lastViewedMealIdProvider = StateProvider<String?>((ref) => null);

final lastViewedMealProvider = Provider((ref) {
  final id = ref.watch(lastViewedMealIdProvider);
  if (id == null) return null;
  return ref.watch(mealByIdProvider(id)); 
});