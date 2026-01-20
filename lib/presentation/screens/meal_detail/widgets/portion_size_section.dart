import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PortionSizeSection extends StatelessWidget {
  const PortionSizeSection({
    super.key,
    required this.controller,
    required this.unitLabel,
    required this.onCommit,
  });

  final TextEditingController controller;
  final String unitLabel;
  final ValueChanged<double?> onCommit;

  void _commit() {
    final text = controller.text.trim().replaceAll(',', '.');
    onCommit(text.isEmpty ? null : double.tryParse(text));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(hintText: '--'),

              // Enter/Done
              onSubmitted: (_) {
                _commit();
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.spacingSm),
        Text(unitLabel, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
