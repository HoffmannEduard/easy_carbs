import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:flutter/material.dart';
import 'insulin_factor_field.dart';

class InsulinBlockRow extends StatelessWidget {
  final String title;
  final bool isNight;

  final TimeOfDay start;
  final TimeOfDay endInclusive;

  final TextEditingController factorController;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final ValueChanged<double?> onCommitFactor;

  const InsulinBlockRow({
    super.key,
    required this.title,
    required this.isNight,
    required this.start,
    required this.endInclusive,
    required this.factorController,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onCommitFactor,
  });

  @override
Widget build(BuildContext context) {
  final timeStyle = Theme.of(context).textTheme.titleLarge;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Titel
      Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (isNight) ...[
            const SizedBox(width: 8),
            Text(
              'über Mitternacht',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),

      const SizedBox(height: 8),

      // Zeiten + Faktor
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TimeValue(
            value: FixedInsulinSchedule.formatGerman(start),
            onTap: onPickStart,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '-',
              style: timeStyle,
            ),
          ),
          _TimeValue(
            value: FixedInsulinSchedule.formatGerman(endInclusive),
            onTap: onPickEnd,
          ),

          const Spacer(),

          SizedBox(
            width: 120,
            child: InsulinFactorField(
              controller: factorController,
              onCommit: onCommitFactor,
            ),
          ),
        ],
      ),
    ],
  );
}

}

class _TimeValue extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const _TimeValue({
    required this.value,
    required this.onTap,
  });

  @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      constraints: const BoxConstraints(
        minWidth: 72,
        minHeight: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium,
      ),
    ),
  );
}

}

