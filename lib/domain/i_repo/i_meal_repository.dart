import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

/// Definiert die Schnittstelle zwischen Domänenlogik [Meal] und Datenquelle
abstract class IMealRepository {
  
  /// Liefert einen Stream aller gespeicherten Mahlzeiten.
  Stream<List<Meal>> watchAllMeals();
  /// Fügt eine neue Mahlzeit hinzu.
  Future<void> addMeal(Meal meal);
  /// Löscht eine Mahlzeit anhand ihrer ID.
  Future<void> deleteMeal(String id);
  /// Lädt eine Mahlzeit anhand ihrer ID.
  Future<Meal?> getMealById(String id);
  /// Aktualisiert eine bestehende Mahlzeit.
  Future<void> updateMeal(Meal meal);

  /// Fügt Nährwerte hinzu oder aktualisiert bestehende.
  Future<void> addOrUpdateNutrition(String mealId, Nutrition nutrition);
  /// Entfernt die Nährwerte einer Mahlzeit.
  Future<void> removeNutrition(String mealId);
}