import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class BESection extends StatelessWidget {
  const BESection({
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
      children: [
        SizedBox(
          width: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '--'),
            onChanged: (value) => onChanged(double.tryParse(value)),
          ),
        ),
        const SizedBox(width: AppSpacing.spacingSm),
        Text(
          unitLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
