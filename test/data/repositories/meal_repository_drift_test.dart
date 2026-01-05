import 'package:drift/native.dart';
import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/db/drift_database.dart';

import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late MealRepositoryDrift repository;

  // Setup: Wird vor jedem Test ausgeführt
  setUp(() {
    // In-Memory Datenbank erstellen (wird nach jedem Test gelöscht)
    database = AppDatabase.forTesting(NativeDatabase.memory());
    final dao = MealDao(database);
    repository = MealRepositoryDrift(dao);
  });

  // Cleanup: Wird nach jedem Test ausgeführt
  tearDown(() async {
    await database.close();
  });

  group('MealRepository CRUD Operations', () {
    
    test('addMeal - Meal nur mit Name (ohne Nutrition)', () async {
      // Arrange (Vorbereitung)
      final meal = Meal(name: 'Pizza Margherita', carbUnit: CarbUnit.gramm);

      // Act (Aktion)
      await repository.addMeal(meal);

      // Assert (Überprüfung)
      final meals = await repository.watchAllMeals().first;
      expect(meals.length, 1);
      expect(meals.first.name, 'Pizza Margherita');
      expect(meals.first.nutrition, isNull);
      expect(meals.first.id, isNotEmpty);
    });

    test('addMeal - Meal mit Nutrition', () async {
      // Arrange
      final nutrition = Nutrition(
        carbs: 45.0,
        sugar: 5.0,
        fat: 12.0,
        protein: 8.0,
      );

      final meal = Meal(
        name: 'Pizza Margherita',
        nutrition: nutrition,
        carbsInUnit: 3.75,
        carbUnit: CarbUnit.be,
        fpe: 1.5,
      );

      // Act
      await repository.addMeal(meal);

      // Assert
      final meals = await repository.watchAllMeals().first;
      expect(meals.length, 1);
      expect(meals.first.nutrition, isNotNull);
      expect(meals.first.nutrition!.carbs, 45.0);
      expect(meals.first.nutrition!.protein, 8.0);
      expect(meals.first.carbsInUnit, 3.75);
      expect(meals.first.carbUnit, CarbUnit.be);
    });

    test('addOrUpdateNutrition - Nutrition nachträglich hinzufügen', () async {
      // Arrange: Meal ohne Nutrition erstellen
      final meal = Meal(name: 'Pizza Margherita', carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Act: Nutrition nachträglich hinzufügen
      final nutrition = Nutrition(
        carbs: 45.0,
        fat: 12.0,
        protein: 8.0,
      );
      await repository.addOrUpdateNutrition(meal.id, nutrition);

      // Assert
      final updatedMeal = await repository.getMealById(meal.id);
      expect(updatedMeal, isNotNull);
      expect(updatedMeal!.nutrition, isNotNull);
      expect(updatedMeal.nutrition!.carbs, 45.0);
      expect(updatedMeal.nutrition!.fat, 12.0);
    });

    test('addOrUpdateNutrition - Bestehende Nutrition aktualisieren', () async {
      // Arrange: Meal mit Nutrition erstellen
      final nutrition = Nutrition(carbs: 45.0, fat: 12.0);
      final meal = Meal(name: 'Pizza', nutrition: nutrition, carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Act: Nutrition aktualisieren
      final updatedNutrition = nutrition.copyWith(
  carbs: 50.0,
  fat: 15.0,
  protein: 10.0,
);

      await repository.addOrUpdateNutrition(meal.id, updatedNutrition);

      // Assert
      final updatedMeal = await repository.getMealById(meal.id);
      expect(updatedMeal!.nutrition!.carbs, 50.0);
      expect(updatedMeal.nutrition!.fat, 15.0);
      expect(updatedMeal.nutrition!.protein, 10.0);
    });

    test('updateMeal - Meal-Daten aktualisieren', () async {
      // Arrange
      final meal = Meal(name: 'Pizza', carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Act: Meal aktualisieren
      final updatedMeal = meal.copyWith(
        name: 'Pizza Margherita Deluxe',
        carbsInUnit: 4.0,
        carbUnit: CarbUnit.be,
        portionsize: 350.0,
        portionUnit: PortionUnit.gramm,
        location: 'Restaurant Roma',
      );
      await repository.updateMeal(updatedMeal);

      // Assert
      final result = await repository.getMealById(meal.id);
      expect(result!.name, 'Pizza Margherita Deluxe');
      expect(result.carbsInUnit, 4.0);
      expect(result.carbUnit, CarbUnit.be);
      expect(result.location, 'Restaurant Roma');
    });

    test('deleteMeal - Meal löschen (inkl. Nutrition)', () async {
      // Arrange
      final nutrition = Nutrition(carbs: 45.0);
      final meal = Meal(name: 'Pizza', nutrition: nutrition, carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Verify meal exists
      var meals = await repository.watchAllMeals().first;
      expect(meals.length, 1);

      // Act
      await repository.deleteMeal(meal.id);

      // Assert
      meals = await repository.watchAllMeals().first;
      expect(meals.length, 0);
      
      // Nutrition sollte auch gelöscht sein
      final deletedMeal = await repository.getMealById(meal.id);
      expect(deletedMeal, isNull);
    });

    test('removeNutrition - Nutrition von Meal entfernen', () async {
      // Arrange
      final nutrition = Nutrition(carbs: 45.0);
      final meal = Meal(name: 'Pizza', nutrition: nutrition, carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Act
      await repository.removeNutrition(meal.id);

      // Assert
      final updatedMeal = await repository.getMealById(meal.id);
      expect(updatedMeal, isNotNull);
      expect(updatedMeal!.nutrition, isNull);
    });

    test('watchAllMeals - Stream liefert Updates', () async {
      // Arrange: Stream abhören
      final stream = repository.watchAllMeals();
      
      // Erwarte 3 Updates: leer → 1 Meal → 2 Meals
      final updates = <List<Meal>>[];
      final subscription = stream.listen(updates.add);

      // Kurz warten damit erster (leerer) Zustand erfasst wird
      await Future.delayed(const Duration(milliseconds: 50));

      // Act
      await repository.addMeal(Meal(name: 'Pizza', carbUnit: CarbUnit.gramm));
      await Future.delayed(const Duration(milliseconds: 50));
      
      await repository.addMeal(Meal(name: 'Pasta', carbUnit: CarbUnit.gramm));
      await Future.delayed(const Duration(milliseconds: 50));

      // Assert
      expect(updates.length, greaterThanOrEqualTo(3));
      expect(updates[0].length, 0); // Initial leer
      expect(updates[1].length, 1); // Nach erstem Insert
      expect(updates[2].length, 2); // Nach zweitem Insert

      await subscription.cancel();
    });

    test('getMealById - Nicht existierendes Meal', () async {
      // Act
      final meal = await repository.getMealById('non-existent-id');

      // Assert
      expect(meal, isNull);
    });

    test('Multiple Meals mit und ohne Nutrition', () async {
      // Arrange
      final meal1 = Meal(name: 'Pizza', nutrition: Nutrition(carbs: 45.0), carbUnit: CarbUnit.gramm);
      final meal2 = Meal(name: 'Salat', carbUnit: CarbUnit.gramm); // Ohne Nutrition
      final meal3 = Meal(name: 'Pasta', carbUnit: CarbUnit.gramm, nutrition: Nutrition(carbs: 60.0));

      // Act
      await repository.addMeal(meal1);
      await repository.addMeal(meal2);
      await repository.addMeal(meal3);

      // Assert
      final meals = await repository.watchAllMeals().first;
      expect(meals.length, 3);
      
      final withNutrition = meals.where((m) => m.nutrition != null).length;
      final withoutNutrition = meals.where((m) => m.nutrition == null).length;
      
      expect(withNutrition, 2);
      expect(withoutNutrition, 1);
    });
  });

  group('Edge Cases & Validation', () {
    
    test('Meal mit allen optionalen Feldern', () async {
      // Arrange
      final nutrition = Nutrition(
        carbs: 45.0,
        sugar: 5.0,
        fat: 12.0,
        protein: 8.0,
      );

      final meal = Meal(
        name: 'Komplette Pizza',
        nutrition: nutrition,
        carbsInUnit: 3.75,
        carbUnit: CarbUnit.be,
        fpe: 1.5,
        location: 'Restaurant Roma',
        portionsize: 350.0,
        portionUnit: PortionUnit.gramm,
        note: 'War sehr lecker',
        categories: 'Italian,Dinner',
        imagePath: 'custom/path.jpg',
      );

      // Act
      await repository.addMeal(meal);

      // Assert
      final savedMeal = await repository.getMealById(meal.id);
      expect(savedMeal!.name, 'Komplette Pizza');
      expect(savedMeal.location, 'Restaurant Roma');
      expect(savedMeal.note, 'War sehr lecker');
      expect(savedMeal.categories, 'Italian,Dinner');
      expect(savedMeal.portionsize, 350.0);
      expect(savedMeal.portionUnit, PortionUnit.gramm);
    });

    test('Timestamp wird automatisch gesetzt', () async {
      // Arrange
      final beforeCreation = DateTime.now();
      final meal = Meal(name: 'Pizza', carbUnit: CarbUnit.gramm);

      // Act
      await repository.addMeal(meal);
      final afterCreation = DateTime.now();

      // Assert
      final savedMeal = await repository.getMealById(meal.id);
      expect(savedMeal!.timestamp.isAfter(beforeCreation.subtract(const Duration(seconds: 1))), isTrue);
      expect(savedMeal.timestamp.isBefore(afterCreation.add(const Duration(seconds: 1))), isTrue);
    });

    test('Default imagePath wird gesetzt', () async {
      // Arrange & Act
      final meal = Meal(name: 'Pizza', carbUnit: CarbUnit.gramm);
      await repository.addMeal(meal);

      // Assert
      final savedMeal = await repository.getMealById(meal.id);
      expect(savedMeal!.imagePath, 'assets/defaults/default-burger.jpg');
    });
  });
}