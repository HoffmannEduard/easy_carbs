import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Anzeige der berechneten Insulineinheiten (IE).
///
/// - Zeigt einen formatierten Wert mit einer Nachkommastelle.
/// - Bei `null` wird ein Platzhalter ("--") dargestellt.
class InsulinUnitsCard extends StatelessWidget {
  final double? insulinUnits;

  const InsulinUnitsCard({
    super.key,
    required this.insulinUnits,
  });

  @override
  Widget build(BuildContext context) {
    final value = insulinUnits == null ? '--' : insulinUnits!.toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(width: AppSpacing.spacingSm),
          Text('IE', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
