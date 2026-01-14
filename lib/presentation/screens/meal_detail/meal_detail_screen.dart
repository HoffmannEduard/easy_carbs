import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/meals/meal_detail_notifier.dart';
import 'widgets/meal_detail_form.dart';

class MealDetailScreen extends ConsumerWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealDetailNotifierProvider(mealId));

    return Scaffold(
      appBar: AppBar(
        title: mealAsync.when(
          loading: () => const Text('Lade Mahlzeit…'),
          error: (_, __) => const Text('Fehler'),
          data: (meal) => Text(
            meal.name,
          ),
        ),
      ),
      body: mealAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (meal) => MealDetailForm(
          meal: meal,
          mealId: mealId,
        ),
      ),
    );
  }
}
