import 'package:flutter/material.dart';

class NameSection extends StatelessWidget {
  const NameSection({
    super.key,
    required this.controller,
    required this.onCommit,
  });

  final TextEditingController controller;
  final ValueChanged<String> onCommit;

  void _commit() {
    onCommit(controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100),
        child: IntrinsicWidth(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.primary,
            ),
            textInputAction: TextInputAction.done,
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
      );
  }
}
