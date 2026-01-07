import 'dart:async';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailNotifier extends FamilyAsyncNotifier<Meal, String> {

  late final IMealRepository _repo;
  //Eventuell CarbUnit aus UserSettings ergänzen

  @override
  Future<Meal> build(String mealId) async {
    _repo = ref.read(mealRepositoryProvider);

    final meal = await _repo.getMealById(mealId);
    if (meal == null) throw Exception('Meal nicht gefunden');
    return meal;
  }

  Future<void> updateName(String newMealName) async {
    final updatedMeal = state.value!.copyWith(name: newMealName);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateLocation(String location) async {
    final updatedMeal = state.value!.copyWith(location: location);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateCarbsInUnit(double? carbsInUnit) async {
    final updatedMeal = state.value!.copyWith(carbsInUnit: carbsInUnit);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateFpe(double? fpe) async {
    final updatedMeal = state.value!.copyWith(fpe: fpe);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updatePortionSize(double? portionsize) async {
    final updatedMeal = state.value!.copyWith(portionsize: portionsize);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateNote(String? note) async {
    final updatedMeal = state.value!.copyWith(note: note);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateCategories(String? categories) async {
    final updatedMeal = state.value!.copyWith(categories: categories);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> updateImagePath(String imagePath) async {
    final updatedMeal = state.value!.copyWith(imagePath: imagePath);
    state = AsyncValue.data(updatedMeal);
    await _repo.updateMeal(updatedMeal);
  }

  Future<void> deleteMeal() async {
    await _repo.deleteMeal(state.value!.id);
  }

  // -----------------------------
  // Nutrition-spezifische Methoden
  // -----------------------------

  Future<void> addOrUpdateNutrition(Nutrition nutrition) async {
    final updatedMeal = state.value!.copyWith(nutrition: nutrition);
    state = AsyncValue.data(updatedMeal);
    await _repo.addOrUpdateNutrition(updatedMeal.id, nutrition);
  }

  Future<void> removeNutrition() async {
    final updatedMeal = state.value!.copyWith(nutrition: null);
    state = AsyncValue.data(updatedMeal);
    await _repo.removeNutrition(updatedMeal.id);
  }

} 

final mealDetailNotifierProvider =
    AsyncNotifierProvider.family<MealDetailNotifier, Meal, String>(
  MealDetailNotifier.new,
);