import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/meal.dart';


// Mapper um zwischen Dirft-Daten und Meal-Entitäten zu konvertieren
// Werden in der Repository-Layer (MealRepositoryDrift) verwendet

class MealMapper {
  static Meal fromDrift(MealsTableData row) {
    return Meal(
      id: row.id,
      name: row.name,
      carbs: row.carbs,
      timestamp: row.timestamp,
      fat: row.fat,
      protein: row.protein,
      location: row.location,
      quantity: row.quantity,
      note: row.note,
      categories: row.categories,
      imagePath: row.imagePath ?? 'assets/images/default_meal.png', // Default
    );
  }

  static MealsTableCompanion toDrift(Meal meal) {
    return MealsTableCompanion(
      id: Value(meal.id),
      name: Value(meal.name),
      carbs: Value(meal.carbs),
      timestamp: Value(meal.timestamp),
      fat: Value(meal.fat),
      protein: Value(meal.protein),
      location: Value(meal.location),
      quantity: Value(meal.quantity),
      note: Value(meal.note),
      categories: Value(meal.categories),
      imagePath: Value(meal.imagePath),
    );
  }
}

