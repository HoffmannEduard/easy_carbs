import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';

class FakeMealRepository implements IMealRepository {
  FakeMealRepository({Meal? initial}) : _meal = initial;

  Meal? _meal;
  Meal? lastUpdatedMeal;
  int updateCalls = 0;

  @override
  Future<Meal?> getMealById(String id) async {
    if (_meal == null) return null;
    return _meal!.id == id ? _meal : null;
  }

  @override
  Future<void> updateMeal(Meal meal) async {
    updateCalls++;
    lastUpdatedMeal = meal;
    _meal = meal;
  }

  @override
  Future<void> deleteMeal(String id) => throw UnimplementedError();

  @override
  Stream<List<Meal>> watchAllMeals() => throw UnimplementedError();

  @override
  Future<void> addMeal(Meal meal) => throw UnimplementedError();
  

  @override
  Future<void> addOrUpdateNutrition(String mealId, Nutrition nutrition) => throw UnimplementedError();

  @override
  Future<void> removeNutrition(String mealId) => throw UnimplementedError();

}