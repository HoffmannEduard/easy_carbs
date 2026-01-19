import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/meal_image_service.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MealCommandsUseCase {
  final Ref _ref;
  final IMealRepository _repo;
  final MealImageService _imageService;
  final String mealId;

  MealCommandsUseCase(this._ref, this._repo, this.mealId)
    : _imageService = MealImageService();

  // -------------------------------------------------
  // Aktuellen Meal aus dem Stream holen (read-only)
  // -------------------------------------------------
  Meal _requireMeal() {
    final mealAsync = _ref.read(mealByIdProvider(mealId));
    final meal = mealAsync.value;

    if (meal == null) {
      throw StateError('Meal $mealId not loaded');
    }
    return meal;
  }

  // -------------------------------------------------
  // Zentrale Update-Hilfe für Meal-Felder
  // -------------------------------------------------
  Future<void> _updateMeal(Meal Function(Meal meal) transform) async {
    final current = _requireMeal();
    final updated = transform(current);
    await _repo.updateMeal(updated);
  }

  // -------------------------------------------------
  // Image
  // -------------------------------------------------

  Future<void> updateImageFromFile(XFile file) async {
    final currentMeal = _requireMeal();
    try {
      await _imageService.deleteMealImage(currentMeal.imagePath);
      final imagePath = await _imageService.saveMealImage(file);
      await _updateMeal((meal) => meal.copyWith(imagePath: imagePath));
    } catch (e) {
      throw StateError('Bild konnte nicht aktualisiert werden: $e');
    }
  }

  Future<void> removeImage() async {
    final currentMeal = _requireMeal();
    try {
      await _imageService.deleteMealImage(currentMeal.imagePath);
      await _updateMeal(
        (meal) => meal.copyWith(imagePath: AppAssets.defaultMealImagePath),
      );
    } catch (e) {
      throw StateError('$e');
    }
  }

  // -------------------------------------------------
  // Basisfelder (alles über updateMeal)
  // -------------------------------------------------

  Future<void> updateName(String name) {
    return _updateMeal((meal) => meal.copyWith(name: name));
  }

  Future<void> updateLocation(String location) {
    return _updateMeal((meal) => meal.copyWith(location: location));
  }

  Future<void> toggleAutocalculate(bool autocalculate){
    return _updateMeal((meal) => meal.copyWith(autocalculate: autocalculate));
  }

  Future<void> updateCarbsInUnit(double? carbsInUnit) {
    return _updateMeal((meal) => meal.copyWith(carbsInUnit: carbsInUnit));
  }

  Future<void> updateFpe(double? fpe) {
    return _updateMeal((meal) => meal.copyWith(fpe: fpe));
  }

  Future<void> updatePortionSize(double? portionSize) {
    return _updateMeal((meal) => meal.copyWith(portionsize: portionSize));
  }

  Future<void> updateNote(String? note) {
    return _updateMeal((meal) => meal.copyWith(note: note));
  }

  Future<void> updateCategories(String? categories) {
    return _updateMeal((meal) => meal.copyWith(categories: categories));
  }

  // -------------------------------------------------
  // Nutrition (über Repo-Methoden)
  // -------------------------------------------------

  Future<void> addOrUpdateNutrition(Nutrition nutrition) async {
    await _repo.addOrUpdateNutrition(mealId, nutrition);
  }

  Future<void> removeNutrition() async {
    await _repo.removeNutrition(mealId);
  }

  // -------------------------------------------------
  // Delete
  // -------------------------------------------------

  Future<void> deleteMeal() async {
    await _repo.deleteMeal(mealId);
  }
}
