import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/meal_list_view_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListViewSettingsNotifier extends Notifier<MealListViewSettings> {

  @override
  MealListViewSettings build() {
    return const MealListViewSettings(
      searchQuery: '',
      sortOrder: MealSortOrder.nameAsc,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSortOrder(MealSortOrder order) {
    state = state.copyWith(sortOrder: order);
  }

  void reset() {
    state = const MealListViewSettings(searchQuery: '', sortOrder: MealSortOrder.nameAsc);
  }

}

final mealListViewSettingsProvider =
    NotifierProvider<
        MealListViewSettingsNotifier,
        MealListViewSettings>(
  MealListViewSettingsNotifier.new,
);
