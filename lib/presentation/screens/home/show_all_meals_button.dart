import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
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
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MealListscreen()));
              },
              child: Center(
                child: Text(
                  "Alle anzeigen",
                ),
              ),
            );
  }
}