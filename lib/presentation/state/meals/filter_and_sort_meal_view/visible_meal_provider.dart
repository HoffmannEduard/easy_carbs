import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/meal_list_view_settings.dart';
import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/meal_list_view_settings_notifier.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visibleMealsProvider = Provider<AsyncValue<List<Meal>>>(
  (ref) {
    final mealStream = ref.watch(mealsStreamProvider);
    final settings = ref.watch(mealListViewSettingsProvider);

    return mealStream.whenData((meals) {
      var result = meals;

      // Suche
      if (settings.searchQuery.isNotEmpty) {
        final q = settings.searchQuery.toLowerCase();
        result = result
            .where(
              (m) => m.name.toLowerCase().contains(q),
            )
            .toList();
      }

      // Sortierung
      result = [...result];
      switch (settings.sortOrder) {
        case MealSortOrder.nameAsc:
          result.sort((a, b) => a.name.compareTo(b.name));
          break;
        case MealSortOrder.nameDesc:
          result.sort((a, b) => b.name.compareTo(a.name));
          break;
      }

      return result;
    });
  },
);
