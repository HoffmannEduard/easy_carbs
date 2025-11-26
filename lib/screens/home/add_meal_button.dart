import 'package:easy_carbs/screens/meal_detail/meal_detail_screen.dart';
import 'package:flutter/material.dart';

class AddMealButton extends StatelessWidget {
  const AddMealButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MealDetailScreen()));
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Color.fromARGB(255, 16, 189, 16), size: 24),
                    Text(
                      "Hinzufügen",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 16, 189, 16),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}