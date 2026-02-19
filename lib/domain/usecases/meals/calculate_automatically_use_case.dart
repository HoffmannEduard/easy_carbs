import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/nutrition_calculator.dart';
import 'package:easy_carbs/domain/services/nutrition_portion_scaler.dart';

/// Use Case zum automatischen Berechnen von BE/KE und FPE für eine Mahlzeit.
///
/// Wird nur ausgeführt, wenn `meal.autocalculate == true` ist und alle
/// notwendigen Eingaben vorhanden sind (Nährwerte + Portionsgröße).
class CalculateAutomaticallyUseCase {
  final IMealRepository _repo;
  final NutritionPortionScaler _scaler;
  final NutritionCalculator _calc;

  CalculateAutomaticallyUseCase(this._repo, this._scaler, this._calc);

  /// Berechnet `carbsInUnit` und optional `fpe` und speichert das Ergebnis.
  /// - Skaliert zuerst die Nährwerte auf die aktuelle Portionsgröße.
  /// - Rechnet danach Kohlenhydrate in die gewählte Einheit (BE/KE) um.
  /// - FPE wird nur berechnet, wenn Fett und Protein vorhanden sind.
  ///
  /// Wenn Autocalc deaktiviert ist oder Eingaben fehlen, passiert nichts.
  Future<void> setCarbsInUnitAndFpe(String mealId) async {
    final meal = await _loadMeal(mealId);

    if (!_shouldAutoCalculate(meal)) return;

    final scaled = _scaleNutritionByPortionSize(meal);
    final carbsInUnit = _calculateCarbsInUnit(meal, scaled);
    final fpe = _calculateFpeOrNull(scaled);

    await _persist(meal, carbsInUnit: carbsInUnit, fpe: fpe);
  }

  /// Lädt eine Mahlzeit und bricht ab, wenn sie nicht existiert.
  Future<Meal> _loadMeal(String mealId) async {
    final meal = await _repo.getMealById(mealId);
    if (meal == null) throw StateError('Meal $mealId not found');
    return meal;
  }

  /// Prüft, ob die automatische Berechnung möglich ist.
  bool _shouldAutoCalculate(Meal meal) {
    return meal.autocalculate == true &&
        meal.nutrition != null &&
        meal.portionsize != null;
  }

  /// Skaliert die gespeicherten Nährwerte auf die gewählte Portionsgröße.
  Nutrition _scaleNutritionByPortionSize(Meal meal) {
    return _scaler.scale(
      nutrition: meal.nutrition!, 
      unit: meal.portionUnit!, 
      portionSize: meal.portionsize!
      );
  }

  /// Berechnet Kohlenhydrate in der gewählten Einheit (BE/KE).
  double _calculateCarbsInUnit(Meal meal, Nutrition n) {
    final carbs = n.carbs;
    if (carbs == null) {
      throw StateError('BE/KE können ohne Kohlenhydrate nicht berechnet werden');
    }

    return _calc.calculateCarbsInUnit(
      carbsGramm: carbs,
      unit: meal.carbUnit,
    );
  }

  /// Berechnet FPE, falls Fett und Protein vorhanden sind.
  double? _calculateFpeOrNull(Nutrition n) {
    final fat = n.fat;
    final protein = n.protein;

    if (fat == null || protein == null) return null;

    return _calc.calculateFpe(
      fatGramm: fat,
      proteinGramm: protein,
    );
  }

  /// Persistiert die berechneten Werte in der Mahlzeit.
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
