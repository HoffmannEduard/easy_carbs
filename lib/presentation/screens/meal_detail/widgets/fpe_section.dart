import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class FPESection extends StatelessWidget {
  const FPESection({
    super.key,
    required this.controller,
    required this.onCommit,
  });

  final TextEditingController controller;
  final ValueChanged<double?> onCommit;

  void _commit() {
    final text = controller.text.trim();
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '--'),
              textInputAction: TextInputAction.done
              ,
              // Enter/Done
              onSubmitted: (_) {
                _commit();
                FocusScope.of(context).unfocus();
              },

              // Fokus weg / Editing abgeschlossen
              onEditingComplete: _commit,
            ),
            ),
          ),
        const SizedBox(width: AppSpacing.spacingSm),
        Text('FPE', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
