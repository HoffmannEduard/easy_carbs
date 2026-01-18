import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

// Mapper um zwischen Drift-Daten und Nutrition-Entitäten zu konvertieren

class NutritionMapper {
  static Nutrition fromDrift(NutritionsTableData row) {
    return Nutrition(
      id: row.id,
      carbs: row.carbs,
      sugar: row.sugar,
      fat: row.fat,
      saturatedFat: row.saturatedFat,
      protein: row.protein,
      weightOnePiece: row.weightOnePiece,
    );
  }

  static NutritionsTableCompanion toDrift(Nutrition nutrition) {
    return NutritionsTableCompanion(
      id: Value(nutrition.id),
      carbs: Value(nutrition.carbs),
      sugar: Value(nutrition.sugar),
      fat: Value(nutrition.fat),
      saturatedFat: Value(nutrition.saturatedFat),
      protein: Value(nutrition.protein),
      weightOnePiece: Value(nutrition.weightOnePiece),
    );
  }
}