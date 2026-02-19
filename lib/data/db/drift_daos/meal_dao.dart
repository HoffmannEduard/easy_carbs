import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import '../drift_tables/meals_table.dart';
import '../drift_tables/nutritions_table.dart';

part 'meal_dao.g.dart';

/// DAO Klasse für Mahlzeiten
/// Verwaltet auch die Beziehung zu Nutritions
@DriftAccessor(tables: [MealsTable, NutritionsTable])
class MealDao extends DatabaseAccessor<AppDatabase> with _$MealDaoMixin {

  MealDao(super.db);

  // ========== INSERT ==========
  
  /// Meal mit optionalen Nutrition-Daten speichern
  Future<String> insertMeal(
    MealsTableCompanion meal,
    NutritionsTableCompanion? nutrition,
  ) async {
    return await transaction(() async {
      // Falls Nutrition-Daten vorhanden sind, erst diese speichern
      if (nutrition != null) {
        await into(nutritionsTable).insert(nutrition);
      }
      
      // Dann Meal speichern
      await into(mealsTable).insert(meal);
      
      // Meal-ID zurückgeben
      return meal.id.value;
    });
  }

  // ========== UPDATE ==========
  
  /// Meal mit optionalen Nutrition-Daten aktualisieren
  Future<bool> updateMeal(
    MealsTableCompanion meal,
    NutritionsTableCompanion? nutrition,
  ) async {
    return await transaction(() async {
      // Meal aktualisieren
      final mealUpdated = await (update(mealsTable)
        ..where((tbl) => tbl.id.equals(meal.id.value)))
        .write(meal);

      // Falls Nutrition-Daten vorhanden sind
      if (nutrition != null) {
        final nutritionId = nutrition.id.value;
        
        // Prüfen ob Nutrition bereits existiert
        final existingNutrition = await (select(nutritionsTable)
          ..where((tbl) => tbl.id.equals(nutritionId)))
          .getSingleOrNull();

        if (existingNutrition != null) {
          // Updaten wenn vorhanden
          await (update(nutritionsTable)
            ..where((tbl) => tbl.id.equals(nutritionId)))
            .write(nutrition);
        } else {
          // Neu anlegen wenn nicht vorhanden
          await into(nutritionsTable).insert(nutrition);
          
          // nutritionId im Meal setzen (falls noch nicht gesetzt)
          if (meal.nutritionId.present && meal.nutritionId.value == null) {
            await (update(mealsTable)
              ..where((tbl) => tbl.id.equals(meal.id.value)))
              .write(MealsTableCompanion(nutritionId: Value(nutritionId)));
          }
        }
      }

      return mealUpdated > 0;
    });
  }

  /// Nur Nutrition zu einem bestehenden Meal hinzufügen/aktualisieren
  Future<bool> addOrUpdateNutritionForMeal(
    String mealId,
    NutritionsTableCompanion nutrition,
  ) async {
    return await transaction(() async {
      final nutritionId = nutrition.id.value;
      
      // Prüfen ob Nutrition bereits existiert
      final existingNutrition = await (select(nutritionsTable)
        ..where((tbl) => tbl.id.equals(nutritionId)))
        .getSingleOrNull();

      if (existingNutrition != null) {
        // Updaten wenn vorhanden
        await (update(nutritionsTable)
          ..where((tbl) => tbl.id.equals(nutritionId)))
          .write(nutrition);
      } else {
        // Neu anlegen wenn nicht vorhanden
        await into(nutritionsTable).insert(nutrition);
      }

      // nutritionId im Meal setzen
      final updated = await (update(mealsTable)
        ..where((tbl) => tbl.id.equals(mealId)))
        .write(MealsTableCompanion(nutritionId: Value(nutritionId)));

      return updated > 0;
    });
  }

  /// Nutrition anhand der MealID von einem Meal entfernen
  Future<bool> removeNutritionFromMeal(String mealId) async {
    return await transaction(() async {
      // Hole das Meal um die nutritionId zu bekommen
      final meal = await (select(mealsTable)
        ..where((tbl) => tbl.id.equals(mealId)))
        .getSingleOrNull();

      if (meal?.nutritionId == null) return false;

      final nutritionId = meal!.nutritionId!;

      // nutritionId im Meal auf null setzen
      await (update(mealsTable)
        ..where((tbl) => tbl.id.equals(mealId)))
        .write(const MealsTableCompanion(nutritionId: Value(null)));

      // Nutrition löschen
      await (delete(nutritionsTable)
        ..where((tbl) => tbl.id.equals(nutritionId)))
        .go();

      return true;
    });
  }

  // ========== DELETE ==========
  
  /// Delete Meal anhand der MealID (inkl. zugehöriger Nutrition)
  Future<int> deleteMeal(String id) async {
    return await transaction(() async {
      // Hole das Meal um die nutritionId zu bekommen
      final meal = await (select(mealsTable)
        ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

      // Meal löschen
      final deletedMeals = await (delete(mealsTable)
        ..where((tbl) => tbl.id.equals(id)))
        .go();

      // Falls Nutrition vorhanden war, diese auch löschen
      if (meal?.nutritionId != null) {
        await (delete(nutritionsTable)
          ..where((tbl) => tbl.id.equals(meal!.nutritionId!)))
          .go();
      }

      return deletedMeals;
    });
  }

  // ========== SELECT ==========
  
  /// Alle Meals mit ihren Nutrition-Daten abrufen (Left Join)
  Stream<List<MealWithNutrition>> watchAllMeals() {
    final query = (select(mealsTable)
      ..orderBy([
        (t) => OrderingTerm(
          expression: t.name.collate(Collate.noCase),
          mode: OrderingMode.asc,
          ),
        ]))
      .join([
        leftOuterJoin(
          nutritionsTable,
          nutritionsTable.id.equalsExp(mealsTable.nutritionId),
        ),
      ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return MealWithNutrition(
          meal: row.readTable(mealsTable),
          nutrition: row.readTableOrNull(nutritionsTable),
        );
      }).toList();
    });
  }

  /// Einzelnes Meal anhand der MealID mit Nutrition abrufen
  Future<MealWithNutrition?> getMealById(String id) async {
    final query = select(mealsTable).join([
      leftOuterJoin(
        nutritionsTable,
        nutritionsTable.id.equalsExp(mealsTable.nutritionId),
      ),
    ])..where(mealsTable.id.equals(id));

    final result = await query.getSingleOrNull();
    
    if (result == null) return null;

    return MealWithNutrition(
      meal: result.readTable(mealsTable),
      nutrition: result.readTableOrNull(nutritionsTable),
    );
  }
}

// Hilfsklasse um Meal und Nutrition zusammen zu transportieren
class MealWithNutrition {
  final MealsTableData meal;
  final NutritionsTableData? nutrition;

  MealWithNutrition({
    required this.meal,
    this.nutrition,
  });
}