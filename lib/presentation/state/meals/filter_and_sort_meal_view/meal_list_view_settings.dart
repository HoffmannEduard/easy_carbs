class MealListViewSettings {
  final String searchQuery;
  final MealSortOrder sortOrder;

  const MealListViewSettings({
    required this.searchQuery,
    required this.sortOrder,
  });

  MealListViewSettings copyWith({
    String? searchQuery,
    MealSortOrder? sortOrder,
  }) {
    return MealListViewSettings(
      searchQuery: searchQuery ?? this.searchQuery,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

enum MealSortOrder {
  nameAsc,
  nameDesc,
}

