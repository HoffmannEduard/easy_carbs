import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/mappers/meal_mapper.dart';
import 'package:easy_carbs/data/mappers/nutrition_mapper.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';

class MealRepositoryDrift implements IMealRepository {
  final MealDao _dao;

  MealRepositoryDrift(this._dao);

  @override
  Stream<List<Meal>> watchAllMeals() {
    return _dao.watchAllMeals().map(
      (mealsWithNutrition) => mealsWithNutrition.map((mwn) {
        // Nutrition-Daten konvertieren falls vorhanden
        final nutrition = mwn.nutrition != null
            ? NutritionMapper.fromDrift(mwn.nutrition!)
            : null;
        
        // Meal-Daten mit Nutrition konvertieren
        return MealMapper.fromDrift(mwn.meal, nutrition: nutrition);
      }).toList(),
    );
  }

  @override
  Future<void> addMeal(Meal meal) async {
    // Nutrition Companion erstellen falls vorhanden
    final nutritionCompanion = meal.nutrition != null
        ? NutritionMapper.toDrift(meal.nutrition!)
        : null;
    
    // Meal mit Nutrition speichern
    await _dao.insertMeal(
      MealMapper.toDrift(meal),
      nutritionCompanion,
    );
  }

  @override
  Future<void> deleteMeal(String id) async {
    await _dao.deleteMeal(id);
  }

  @override
  Future<Meal?> getMealById(String id) async {
    final mealWithNutrition = await _dao.getMealById(id);
    
    if (mealWithNutrition == null) return null;

    // Nutrition-Daten konvertieren falls vorhanden
    final nutrition = mealWithNutrition.nutrition != null
        ? NutritionMapper.fromDrift(mealWithNutrition.nutrition!)
        : null;

    return MealMapper.fromDrift(
      mealWithNutrition.meal,
      nutrition: nutrition,
    );
  }

  @override
  Future<void> updateMeal(Meal meal) async {
    // Nutrition Companion erstellen falls vorhanden
    final nutritionCompanion = meal.nutrition != null
        ? NutritionMapper.toDrift(meal.nutrition!)
        : null;

    await _dao.updateMeal(
      MealMapper.toDrift(meal),
      nutritionCompanion,
    );
  }

  // Spezielle Methode für deinen Dialog-Use-Case:
  // Nutrition nachträglich zu einem Meal hinzufügen/aktualisieren
  @override
  Future<void> addOrUpdateNutrition(String mealId, Nutrition nutrition) async {
    await _dao.addOrUpdateNutritionForMeal(
      mealId,
      NutritionMapper.toDrift(nutrition),
    );
  }

  // Nutrition von einem Meal entfernen
  @override
  Future<void> removeNutrition(String mealId) async {
    await _dao.removeNutritionFromMeal(mealId);
  }
}