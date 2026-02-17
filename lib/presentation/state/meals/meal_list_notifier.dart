import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/services/meal_image_service.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Liefert einen Stream aller Mahlzeiten und bietet einfache Commands zum Anlegen und Löschen
class MealListNotifier extends StreamNotifier<List<Meal>> {
  late final IMealRepository _repo;

  /// Baut den Stream für alle Mahlzeiten auf.
  @override
  Stream<List<Meal>> build() {
    _repo = ref.read(mealRepositoryProvider);
    return _repo.watchAllMeals();
  }

  /// Legt eine neue Mahlzeit an und gibt deren ID zurück.
  /// - Übernimmt die Kohlenhydrat-Einheit aus den [UserSettings].
  /// - Speichert optional ein Bild und setzt sonst das Standardbild.
  /// - Setzt eine Default-Portionsgröße passend zu [portionUnit].
  Future<String> createMeal({
    required String name,
    String? location,
    XFile? imageFile,
    required PortionUnit portionUnit,
  }) async {
    final settings =
        await ref.read(userSettingsRepositoryProvider).getSettings();

    String imagePath =
        imageFile != null
            ? await MealImageService().saveMealImage(imageFile)
            : AppAssets.defaultMealImagePath;

    final meal = Meal(
      name: name,
      location: location,
      carbUnit: settings!.carbUnit,
      imagePath: imagePath,
      portionUnit: portionUnit,
      portionsize: _defaultPortionSizeFor(portionUnit),
    );
    await _repo.addMeal(meal);
    return meal.id;
  }

  Future<void> deleteMeal(String id) async {
    await _repo.deleteMeal(id);
  }

  /// Liefert eine sinnvolle Default-Portionsgröße je Einheit.
  /// - Gramm: 100 g
  /// - Stück/Portion: 1
  double _defaultPortionSizeFor(PortionUnit unit) {
    switch (unit) {
      case PortionUnit.gramm:
        return 100.0;
      case PortionUnit.piece:
      case PortionUnit.portion:
        return 1.0;
    }
  }
}

/// Provider für die Mahlzeitenliste als Stream.
final mealListNotifierProvider =
    StreamNotifierProvider<MealListNotifier, List<Meal>>(MealListNotifier.new);
