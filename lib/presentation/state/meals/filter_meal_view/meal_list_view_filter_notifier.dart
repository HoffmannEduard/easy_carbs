import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier für den Filterzustand der Mahlzeitenliste.
/// Verwaltet aktuell nur die Suchanfrage
class MealListViewFilterNotifier extends Notifier<MealListViewFilter> {
  /// Initialisiert den Filter mit leerer Suchanfrage.
  @override
  MealListViewFilter build() {
    return const MealListViewFilter(searchQuery: '');
  }

  /// Setzt die Suchanfrage.
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query.trim());
  }

  /// Setzt den Filterzustand auf die Standardwerte zurück.
  void reset() {
    state = const MealListViewFilter(searchQuery: '');
  }
}

/// Provider für den Filterzustand der Mahlzeitenliste.
final mealListViewFilterProvider =
    NotifierProvider<
        MealListViewFilterNotifier,
        MealListViewFilter>(
  MealListViewFilterNotifier.new,
);
