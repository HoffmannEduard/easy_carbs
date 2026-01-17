import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListViewFilterNotifier extends Notifier<MealListViewFilter> {

  @override
  MealListViewFilter build() {
    return const MealListViewFilter(
      searchQuery: '',
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void reset() {
    state = const MealListViewFilter(searchQuery: '');
  }

}

final mealListViewFilterProvider =
    NotifierProvider.autoDispose<
        MealListViewFilterNotifier,
        MealListViewFilter>(
  MealListViewFilterNotifier.new,
);
