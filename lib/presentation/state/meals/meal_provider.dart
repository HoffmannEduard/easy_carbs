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

/// Provider für den Drift-DAO der Mahlzeiten.
/// Der DAO erhält die Datenbankinstanz über [driftDbProvider].
final mealDaoProvider = Provider<MealDao>((ref) {
  final db = ref.watch(driftDbProvider);
  return MealDao(db);
});

/// Bindet [IMealRepository] an die Drift-Implementierung.
final mealRepositoryProvider = Provider<IMealRepository>((ref) {
  final dao = ref.watch(mealDaoProvider); 
  return MealRepositoryDrift(dao);
});


/// Abgeleiteter Provider für die Meal-Detailansicht.
/// Sucht ein Meal im aktuellen Stream ([mealListNotifierProvider]) und liefert:
/// - loading, solange das Meal noch nicht im Stream ist
/// - error, falls der Stream fehlschlägt
/// - data, sobald das Meal verfügbar ist
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

/// Liefert die Anzahl der gespeicherten Mahlzeiten als AsyncValue.
final mealCountAsyncProvider = Provider<AsyncValue<int>>((ref) {
  final mealsAsync = ref.watch(mealListNotifierProvider);
  return mealsAsync.whenData((meals) => meals.length);
});



/// Provider für schreibende Aktionen auf einer Mahlzeit.
/// Persistiert Änderungen über das Repository; Aktualisierungen kommen anschließend über den Stream zurück.
final mealCommandsProvider =
    Provider.family<MealCommandsUseCase, String>((ref, mealId) {
  final repo = ref.watch(mealRepositoryProvider);
  return MealCommandsUseCase(ref, repo, mealId);
});

/// Provider für die BE/KE- und FPE-Berechnungen.
final nutritionCalculatorProvider = Provider<NutritionCalculator>((ref) {
  return const NutritionCalculator();
});

/// Provider zum Skalieren von Nährwerten anhand der Portionsgröße.
final nutritionPortionScalerProvider = Provider<NutritionPortionScaler>((ref) {
  return const NutritionPortionScaler();
});

/// Use Case für die automatische Berechnung von BE/KE und FPE.
final calculateAutomaticallyUseCaseProvider =
    Provider<CalculateAutomaticallyUseCase>((ref) {
  final repo = ref.watch(mealRepositoryProvider);
  final calc = ref.watch(nutritionCalculatorProvider);
  final scaler = ref.watch(nutritionPortionScalerProvider);
  return CalculateAutomaticallyUseCase(repo, scaler, calc);
});

/// ID der zuletzt angesehenen Mahlzeit
final lastViewedMealIdProvider = StateProvider<String?>((ref) => null);

/// Liefert die zuletzt angesehene Mahlzeit (oder `null`, wenn keine gesetzt ist).
final lastViewedMealProvider = Provider((ref) {
  final id = ref.watch(lastViewedMealIdProvider);
  if (id == null) return null;
  return ref.watch(mealByIdProvider(id)); 
});