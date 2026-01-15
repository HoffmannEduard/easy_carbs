import 'package:flutter/material.dart';
import 'nutrition_table.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

class NutritionSection extends StatelessWidget {
  const NutritionSection({
    super.key,
    required this.nutrition,
    required this.onEdit,
    required this.onDelete,
  });

  final Nutrition nutrition;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Nährwerte', style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showActions(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        NutritionTable(nutrition: nutrition),
      ],
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Bearbeiten'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Löschen'),
                onTap: () {
                  Navigator.pop(context);
                  onDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
