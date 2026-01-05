import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';

// Mapper um zwischen Drift-Daten und Meal-Entitäten zu konvertieren
// Werden in der Repository-Layer (MealRepositoryDrift) verwendet

class MealMapper {
  // Konvertiert von Drift zu Meal Entity
  // nutrition muss separat übergeben werden (wird per Join geholt)
  static Meal fromDrift(MealsTableData row, {Nutrition? nutrition}) {
    return Meal(
      id: row.id,
      name: row.name,
      timestamp: row.timestamp,
      carbsInUnit: row.carbsInUnit,
      carbUnit: _parseCarbUnit(row.carbUnit),
      fpe: row.fpe,
      location: row.location,
      nutrition: nutrition,
      portionsize: row.portionsize,
      portionUnit: row.portionUnit != null ? _parsePortionUnit(row.portionUnit!) : null,
      note: row.note,
      categories: row.categories,
      imagePath: row.imagePath,
    );
  }

  // Konvertiert von Meal Entity zu Drift Companion
  // Speichert nur die Meal-Daten, Nutrition muss separat gespeichert werden
  static MealsTableCompanion toDrift(Meal meal) {
    return MealsTableCompanion(
      id: Value(meal.id),
      name: Value(meal.name),
      timestamp: Value(meal.timestamp),
      carbsInUnit: Value(meal.carbsInUnit),
      carbUnit: Value(meal.carbUnit.name),
      fpe: Value(meal.fpe),
      location: Value(meal.location),
      nutritionId: Value(meal.nutrition?.id),
      portionsize: Value(meal.portionsize),
      portionUnit: Value(meal.portionUnit?.name),
      note: Value(meal.note),
      categories: Value(meal.categories),
      imagePath: Value(meal.imagePath),
    );
  }

  // Hilfsmethoden zum Parsen der Enums
  static CarbUnit _parseCarbUnit(String value) {
    try {
      return CarbUnit.values.firstWhere((e) => e.name == value);
    } catch (e) {
      //TODO Rückgabe bei Fehler muss noch bearbeitet werden
      return CarbUnit.gramm;
    }
  }

  static PortionUnit? _parsePortionUnit(String value) {
    try {
      return PortionUnit.values.firstWhere((e) => e.name == value);
    } catch (e) {
      return null;
    }
  }
}