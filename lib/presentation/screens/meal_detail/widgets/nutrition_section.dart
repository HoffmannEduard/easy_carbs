import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'nutrition_table.dart';

class NutritionSection extends StatelessWidget {
  const NutritionSection({
    super.key,
    required this.nutrition,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.portionUnit,
  });

  final Nutrition? nutrition;
  final VoidCallback onAdd;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final PortionUnit portionUnit;

  @override
  Widget build(BuildContext context) {
    if (nutrition == null) {
      return Center(
        child: ElevatedButton(
          onPressed: onAdd,
          child: const Text('Nährwerte hinzufügen'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(portionUnit == PortionUnit.portion?
              'Nährwerte je Portion' : 'Nährwerte je 100 Gramm',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showActions(context),
            ),
          ],
        ),
        const SizedBox(height: 2),
        NutritionTable(nutrition: nutrition!),
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
