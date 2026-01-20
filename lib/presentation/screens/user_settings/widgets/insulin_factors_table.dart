import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:flutter/material.dart';

class InsulinFactorsTable extends StatelessWidget {
  final FixedInsulinFactors insulinFactors;
  final VoidCallback onEdit;

  const InsulinFactorsTable({
    super.key,
    required this.insulinFactors,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = FixedInsulinSchedule.normalize(insulinFactors);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Insulin Faktoren', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text('Bearbeiten'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...InsulinBlockIdX.ordered.map((id) {
              final f = normalized.byId(id);
              final endInclusive = FixedInsulinSchedule.displayEndInclusive(f.endTime);

              final range =
                  '${FixedInsulinSchedule.formatGerman(f.startTime)} – ${FixedInsulinSchedule.formatGerman(endInclusive)}';

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _Row(
                  title: id.label,
                  valueLeft: range,
                  valueRight: f.insulinFactor.toString(),
                  showNightHint: id == InsulinBlockId.night,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String valueLeft;  // Zeitbereich
  final String valueRight; // Faktor
  final bool showNightHint;

  const _Row({
    required this.title,
    required this.valueLeft,
    required this.valueRight,
    required this.showNightHint,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: labelStyle)),
            if (showNightHint)
              Text('über Mitternacht', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: Text(valueLeft)),
            const SizedBox(width: 12),
            Text('Faktor: $valueRight'),
          ],
        ),
      ],
    );
  }
}
