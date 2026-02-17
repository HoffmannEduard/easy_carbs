import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter_notifier.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Liefert die sichtbaren Mahlzeiten basierend auf aktuellem Filter.
/// Kombiniert:
/// - den Stream aller Mahlzeiten ([mealListNotifierProvider])
/// - den aktuellen Filterzustand ([mealListViewFilterProvider])
final visibleMealsProvider = Provider<AsyncValue<List<Meal>>>((ref) {
  final mealStream = ref.watch(mealListNotifierProvider);
  final filter = ref.watch(mealListViewFilterProvider);

  return mealStream.whenData((meals) {
    final q = filter.searchQuery.trim().toLowerCase();
    if (q.isEmpty) return meals;

    return meals.where((m) {
      final name = m.name.toLowerCase();
      // Location mit durchsuchen
      final location = (m.location ?? '').toLowerCase();
      return name.contains(q) || location.contains(q);
    }).toList();
  });
});

