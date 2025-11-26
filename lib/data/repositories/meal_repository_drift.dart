import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/mappers/meal_mapper.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';

class MealRepositoryDrift implements IMealRepository {
  final MealDao _dao;

// Änderungen hier müssen auch in der MealDao-Klasse reflektiert werden

  MealRepositoryDrift(this._dao);

  @override
  Stream<List<Meal>> watchAllMeals() {
    return _dao.watchAllMeals().map(
      (rows) => rows.map(MealMapper.fromDrift).toList(),
    );
  }

  @override
  Future<void> addMeal(Meal meal) async {
    final companion = MealMapper.toDrift(meal);
    await _dao.insertMealCompanion(companion);
  }

  @override
  Future<void> deleteMeal(String id) async {
    await _dao.deleteMealById(id);
  }
  
}
