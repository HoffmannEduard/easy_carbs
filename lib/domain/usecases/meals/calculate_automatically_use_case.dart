import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/nutrition_calculator.dart';
import 'package:easy_carbs/domain/services/nutrition_portion_scaler.dart';

class CalculateAutomaticallyUseCase {
  final IMealRepository _repo;
  final NutritionPortionScaler _scaler;
  final NutritionCalculator _calc;

  CalculateAutomaticallyUseCase(this._repo, this._scaler, this._calc);

  Future<void> setCarbsInUnitAndFpe(String mealId) async {
    final meal = await _loadMeal(mealId);

    if (!_shouldAutoCalculate(meal)) return;

    final scaled = _scaleNutritionByPortionSize(meal);
    final carbsInUnit = _calculateCarbsInUnit(meal, scaled);
    final fpe = _calculateFpeOrNull(scaled);

    await _persist(meal, carbsInUnit: carbsInUnit, fpe: fpe);
  }


  Future<Meal> _loadMeal(String mealId) async {
    final meal = await _repo.getMealById(mealId);
    if (meal == null) throw StateError('Meal $mealId not found');
    return meal;
  }


  bool _shouldAutoCalculate(Meal meal) {
    return meal.autocalculate == true &&
        meal.nutrition != null &&
        meal.portionsize != null;
  }


  Nutrition _scaleNutritionByPortionSize(Meal meal) {
    return _scaler.scale(
      nutrition: meal.nutrition!, 
      unit: meal.portionUnit!, 
      portionSize: meal.portionsize!
      );
  }

  double _calculateCarbsInUnit(Meal meal, Nutrition n) {
    final carbs = n.carbs;
    if (carbs == null) {
      throw StateError('Cannot calculate carbsInUnit without carbs');
    }

    return _calc.calculateCarbsInUnit(
      carbsGramm: carbs,
      unit: meal.carbUnit,
    );
  }

  double? _calculateFpeOrNull(Nutrition n) {
    final fat = n.fat;
    final protein = n.protein;

    if (fat == null || protein == null) return null;

    return _calc.calculateFpe(
      fatGramm: fat,
      proteinGramm: protein,
    );
  }

  Future<void> _persist(
    Meal meal, {
    required double carbsInUnit,
    required double? fpe,
  }) {
    return _repo.updateMeal(
      meal.copyWith(
        carbsInUnit: carbsInUnit,
        fpe: fpe,
      ),
    );
  }
}
