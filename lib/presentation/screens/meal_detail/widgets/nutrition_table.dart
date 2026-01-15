import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

class NutritionTable extends StatelessWidget {
  const NutritionTable({super.key, required this.nutrition});

  final Nutrition nutrition;

  TableRow _row(String label, double? value, BuildContext context) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            value != null ? value.toString() : '--',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _row('Kohlenhydrate (g)', nutrition.carbs, context),
        _row('Zucker (g)', nutrition.sugar, context),
        _row('Fett (g)', nutrition.fat, context),
        _row('Protein (g)', nutrition.protein, context),
      ],
    );
  }
}
