import 'package:easy_carbs/presentation/screens/home/add_meal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMealButton extends ConsumerWidget {
  const AddMealButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => const AddMealDialog(),
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
