import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowAllMealsButton extends ConsumerWidget {
  const ShowAllMealsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ts = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final mealCountProvider = ref.watch(mealCountAsyncProvider);
    final mealCount = mealCountProvider.when(
      data: (count) => '$count',
      loading: () => '-',
      error: (_, __) => "--"
      );

    return Expanded(
      child: SizedBox(
        height: 100,
        child: OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MealListscreen(),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: cs.onSurface
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mealCount,
                style: ts.titleLarge?.copyWith(
                  color: cs.primary),
                ),
              SizedBox(height: 4),
              Text(
                'Einträge',
                style: ts.titleLarge?.copyWith(
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
