import 'package:flutter/material.dart';

/// Eingabefeld für einen Insulinfaktor.
///
/// - Übergibt den geparsten Wert (oder `null`) über [onCommit].
/// - Commit erfolgt bei "Done" oder Abschluss der Bearbeitung.
class InsulinFactorField extends StatelessWidget {
  const InsulinFactorField({
    super.key,
    required this.controller,
    required this.onCommit,
  });

  final TextEditingController controller;
  final ValueChanged<double?> onCommit;

  void _commit() {
    final text = controller.text.trim().replaceAll(',', '.');
    onCommit(text.isEmpty ? null : double.tryParse(text));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: 'Faktor',
          isDense: true,
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) {
          _commit();
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: _commit,
      ),
    );
  }
}
