import 'package:flutter/material.dart';

/// Eingabefeld für den Namen einer Mahlzeit.
///
/// - Übergibt den getrimmten Text über [onCommit].
/// - Commit erfolgt bei "Done" oder beim Verlassen des Feldes.
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
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
        textInputAction: TextInputAction.done,
        // Enter/Done
          onSubmitted: (_) {
            _commit();
            FocusScope.of(context).unfocus();
          },
      
          // Fokus weg / Editing abgeschlossen
          onEditingComplete: _commit,
        ),
      );
  }
}
