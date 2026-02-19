import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/meal_image_service.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Bündelt schreibende Aktionen (Commands) rund um eine Mahlzeit.
/// Liest den aktuellen Zustand über Riverpod [mealByIdProvider] und
/// persistiert Änderungen über das [IMealRepository].
/// Bildoperationen werden über [MealImageService] gekapselt.
class MealCommandsUseCase {
  final Ref _ref;
  final IMealRepository _repo;
  final MealImageService _imageService;
  final String mealId;

  MealCommandsUseCase(this._ref, this._repo, this.mealId)
    : _imageService = MealImageService();

  /// Liefert die aktuell geladene Mahlzeit aus dem Provider oder wirft einen Fehler.
  /// Wird genutzt, um alle Commands auf einer konsistenten Basis auszuführen.
  Meal _requireMeal() {
    final mealAsync = _ref.read(mealByIdProvider(mealId));
    final meal = mealAsync.value;

    if (meal == null) {
      throw StateError('Meal $mealId not loaded');
    }
    return meal;
  }

  /// Wendet eine Transformation auf die aktuelle Mahlzeit an und speichert sie.
  Future<void> _updateMeal(Meal Function(Meal meal) transform) async {
    final current = _requireMeal();
    final updated = transform(current);
    await _repo.updateMeal(updated);
  }

  // -------------------------------------------------
  // Image
  // -------------------------------------------------
  /// Ersetzt das Mahlzeitenbild durch [file] und aktualisiert den gespeicherten Pfad.
  /// Löscht zuvor ein vorhandenes Bild.
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

  /// Entfernt das Mahlzeitenbild und setzt den Pfad auf das Standardbild.
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

  /// Aktiviert/Deaktiviert die automatische Berechnung (BE/KE & FPE).
  Future<void> toggleAutocalculate(bool autocalculate) async {
  final meal = _requireMeal();
  if (autocalculate) {
    if (meal.portionsize == null || meal.nutrition == null) {
      throw StateError('Portionsgröße und Nährwerte hinzufügen');
    }
  }
  await _repo.updateMeal(
    meal.copyWith(autocalculate: autocalculate),
  );
}

  Future<void> updateName(String name) {
    return _updateMeal((meal) => meal.copyWith(name: name));
  }

  Future<void> updateLocation(String location) {
    return _updateMeal((meal) => meal.copyWith(location: location));
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
