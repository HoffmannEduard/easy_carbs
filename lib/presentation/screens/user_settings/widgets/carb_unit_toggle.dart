import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:flutter/material.dart';

/// Toggle-Komponente zur Auswahl der Kohlenhydrateinheit (BE oder KE).
///
/// Der aktuell ausgewählte Wert wird über [selected] gesteuert.
/// Änderungen werden über [onSelected] nach außen delegiert.
class CarbUnitToggle extends StatelessWidget {
  final CarbUnit selected;
  final ValueChanged<CarbUnit> onSelected;

  const CarbUnitToggle({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = CarbUnit.values.map((u) => u == selected).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kohlenhydrat-Einheit',
        style: Theme.of(context).textTheme.titleMedium,),
        const SizedBox(height: 8),
        ToggleButtons(
          isSelected: isSelected,
          onPressed: (index) => onSelected(CarbUnit.values[index]),
          children: CarbUnit.values
              .map(
                (unit) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(unit.label),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
