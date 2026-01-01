import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

abstract class IMealRepository {
  
  Stream<List<Meal>> watchAllMeals();
  Future<void> addMeal(Meal meal);
  Future<void> deleteMeal(String id);
  Future<Meal?> getMealById(String id);
  Future<void> updateMeal(Meal meal);

  Future<void> addOrUpdateNutrition(String mealId, Nutrition nutrition);
  Future<void> removeNutrition(String mealId);
}