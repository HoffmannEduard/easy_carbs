import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class FPESection extends StatelessWidget {
  const FPESection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
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
          'FPE',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
