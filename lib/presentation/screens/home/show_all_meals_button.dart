import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:flutter/material.dart';

class ShowAllMealsButton extends StatelessWidget {
  const ShowAllMealsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () {
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