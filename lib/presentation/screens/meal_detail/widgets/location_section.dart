import 'package:flutter/material.dart';

/// Eingabefeld für den Ort einer Mahlzeit.
///
/// - Übergibt den getrimmten Text über [onCommit].
/// - Commit erfolgt bei "Done" oder beim Verlassen des Feldes.
class LocationSection extends StatelessWidget {
  const LocationSection({
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
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              hintText: 'Location',
              contentPadding: EdgeInsets.all(8),
              filled: false,
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