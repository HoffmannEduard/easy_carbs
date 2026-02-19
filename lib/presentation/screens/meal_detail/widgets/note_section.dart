import 'package:flutter/material.dart';

/// Mehrzeiliges Eingabefeld für Notizen zur Mahlzeit.
///
/// - Übergibt Änderungen fortlaufend über [onChanged].
class NoteSection extends StatelessWidget {
  const NoteSection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 3,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: 'Notizen...',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        contentPadding: const EdgeInsets.all(12),
      ),
      onChanged: onChanged,
    );
  }
}
