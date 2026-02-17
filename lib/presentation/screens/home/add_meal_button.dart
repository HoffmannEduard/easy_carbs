import 'package:easy_carbs/presentation/screens/add_meal/add_meal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Button zur Navigation zum [AddMealScreen].
///
/// Wird auf der Startseite als prominente Aktion dargestellt.
class AddMealButton extends ConsumerWidget {
  const AddMealButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final ts = Theme.of(context).textTheme;

    return Expanded(
      child: SizedBox(
        height: 100,
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddMealScreen(),
              ),
            );
          },
          style: FilledButton.styleFrom(
            side: BorderSide(
              color: cs.surfaceContainerLowest
            ),
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
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
                'Neue',
                style: ts.titleLarge?.copyWith(
                  color: cs.onPrimary),
                ),
              SizedBox(height: 4),
              Text(
                'Mahlzeit',
                style: ts.titleLarge?.copyWith(
                  color: cs.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
