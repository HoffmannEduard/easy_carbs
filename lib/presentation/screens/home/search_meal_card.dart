import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/meal_list_view_settings_notifier.dart';
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
    ref.read(mealListViewSettingsProvider.notifier).setSearchQuery(_controller.text);
    _controller.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MealListscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Suchen…',
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _submitSearch(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _submitSearch,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
