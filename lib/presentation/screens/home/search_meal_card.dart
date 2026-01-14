import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/meal_list_view_filter_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMealCard extends ConsumerStatefulWidget {
  const SearchMealCard({super.key});

  @override
  ConsumerState<SearchMealCard> createState() => _SearchMealCardState();
}

class _SearchMealCardState extends ConsumerState<SearchMealCard> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch() {
    _focusNode.unfocus();
    ref.read(mealListViewFilterProvider.notifier).setSearchQuery(_controller.text);
    _controller.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MealListscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Suchen…',
                prefixIcon: Icon(Icons.search),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submitSearch(),
            ),
          ),
          const SizedBox(width: AppSpacing.spacingSm),
          ElevatedButton(
            onPressed: _submitSearch,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
