import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListNotifier extends StreamNotifier<List<Meal>> {

  late final IMealRepository _repo;

  @override
  Stream<List<Meal>> build() {
    _repo = ref.read(mealRepositoryProvider);
    return _repo.watchAllMeals();
  }

  //Create Meal, CarbUnits aus UserSettings übernehmen
  Future<String> createMeal({
    required String name,
    String? location,
  }) async {
    final settings = await ref
      .read(userSettingsRepositoryProvider)
      .getSettings();

    final meal = Meal(
      name: name,
      location: location,
      carbUnit: settings!.carbUnit,
    );
    await _repo.addMeal(meal);
    return meal.id;
  }

  Future<void> deleteMeal(String id) async {
    await _repo.deleteMeal(id);
  }

}

final mealListNotifierProvider =
    StreamNotifierProvider<MealListNotifier, List<Meal>>(
  MealListNotifier.new,
);
