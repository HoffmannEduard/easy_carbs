class MealListViewFilter {
  final String searchQuery;

  const MealListViewFilter({
    required this.searchQuery,
  });

  MealListViewFilter copyWith({
    String? searchQuery,
  }) {
    return MealListViewFilter(
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}


