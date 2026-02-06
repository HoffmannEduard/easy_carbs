import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter_notifier.dart';

class MealSearchBar extends ConsumerStatefulWidget {
  const MealSearchBar({super.key});

  @override
  ConsumerState<MealSearchBar> createState() => _MealSearchBarState();
}

class _MealSearchBarState extends ConsumerState<MealSearchBar> {
  late final SearchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(mealListViewFilterProvider);

    // Sync: wenn Filter extern resettet wird, soll die UI folgen
    if (_controller.text != filter.searchQuery) {
      _controller.text = filter.searchQuery;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: SearchBar(
        controller: _controller,
        hintText: 'Suchen…',
        leading: const Icon(Icons.search),
        trailing: [
          if (filter.searchQuery.isNotEmpty)
            IconButton(
              tooltip: 'Löschen',
              onPressed: () {
                _controller.clear();
                ref.read(mealListViewFilterProvider.notifier).reset();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.close),
            ),
        ],
        onChanged: (value) {
          ref.read(mealListViewFilterProvider.notifier).setSearchQuery(value);
        },
        onSubmitted: (value) {
          ref.read(mealListViewFilterProvider.notifier).setSearchQuery(value);
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
