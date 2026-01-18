import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PortionSizeSection extends StatelessWidget {
  const PortionSizeSection({
    super.key,
    required this.controller,
    required this.unitLabel,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String unitLabel;
  final ValueChanged<double?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '--'),
              onChanged: (value) => onChanged(double.tryParse(value)),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.spacingSm),
        Text(unitLabel, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
