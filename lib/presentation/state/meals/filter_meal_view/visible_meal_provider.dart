import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter_notifier.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visibleMealsProvider = Provider<AsyncValue<List<Meal>>>(
  (ref) {
    final mealStream = ref.watch(mealListNotifierProvider);
    final settings = ref.watch(mealListViewFilterProvider);

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

      return result;
    });
  },
);
