import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class BESection extends StatelessWidget {
  const BESection({
    super.key,
    required this.controller,
    required this.unitLabel,
    required this.onCommit,
    required this.readonly,
  });

  final TextEditingController controller;
  final String unitLabel;
  final ValueChanged<double?> onCommit;
  final bool readonly;

  void _commit() {
    final text = controller.text.trim().replaceAll(',', '.');
    onCommit(text.isEmpty ? null : double.tryParse(text));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextField(
              controller: controller,
              readOnly: readonly,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '--',
                filled: !readonly,
                ),
              textInputAction: TextInputAction.done,

              // Enter/Done
              onSubmitted: readonly ? null : (_) {
                _commit();
                FocusScope.of(context).unfocus();
              },

              // Fokus weg / Editing abgeschlossen
              onEditingComplete: readonly ? null : _commit,
            ),),
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
