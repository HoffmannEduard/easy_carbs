import 'package:easy_carbs/presentation/screens/add_meal/add_meal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMealButton extends ConsumerWidget {
  const AddMealButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddMealScreen(),
      ),
    );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Color.fromARGB(255, 16, 189, 16)),
          SizedBox(width: 8),
          Text(
            'Hinzufügen',
            style: TextStyle(
              color: Color.fromARGB(255, 16, 189, 16),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
