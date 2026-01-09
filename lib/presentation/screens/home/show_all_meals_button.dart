import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/meal_list_view_settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowAllMealsButton extends ConsumerWidget {
  const ShowAllMealsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
              onPressed: () {
                ref.read(mealListViewSettingsProvider.notifier).reset();
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MealListscreen()));
              },
              child: Center(
                child: Text(
                  "Alle anzeigen",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            );
  }
}