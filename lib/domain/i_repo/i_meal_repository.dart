import 'package:easy_carbs/domain/entities/meal.dart';

abstract class IMealRepository {

  Stream<List<Meal>> watchAllMeals();

  Future<void> addMeal(Meal meal);

  Future<void> deleteMeal(String id);
}