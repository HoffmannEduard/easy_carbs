import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:flutter/material.dart';

import 'compact_time_field.dart';
import 'insulin_factor_field.dart';

class InsulinBlockRow extends StatelessWidget {
  final String title;
  final bool showNightHint;

  final TimeOfDay start;
  final TimeOfDay endInclusive;

  final TextEditingController factorController;
  final ValueChanged<double?> onCommitFactor;

  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  const InsulinBlockRow({
    super.key,
    required this.title,
    required this.showNightHint,
    required this.start,
    required this.endInclusive,
    required this.factorController,
    required this.onCommitFactor,
    required this.onPickStart,
    required this.onPickEnd,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: titleStyle)),
            if (showNightHint)
              Text('über Mitternacht', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CompactTimeField(
                label: 'Start',
                value: FixedInsulinSchedule.formatGerman(start),
                onTap: onPickStart,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CompactTimeField(
                label: 'Ende',
                value: FixedInsulinSchedule.formatGerman(endInclusive),
                onTap: onPickEnd,
              ),
            ),
            const SizedBox(width: 8),
            InsulinFactorField(
              controller: factorController,
              onCommit: onCommitFactor,
            ),
          ],
        ),
      ],
    );
  }
}
