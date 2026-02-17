import 'package:flutter/material.dart';

/// Formular-Sektion zur Eingabe des Gewichts pro Stück (in Gramm).
///
/// Wird verwendet, wenn die Portionsangabe über `Stück` erfolgt.
class WeightPerPieceSection extends StatelessWidget {
  final TextEditingController weightOnePieceController;

  /// Optionaler FocusNode für "Next"-Navigation
  final FocusNode? focusNode;

  final VoidCallback? onSubmitted;

  const WeightPerPieceSection({
    super.key,
    required this.weightOnePieceController,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gewicht je Stück in Gramm',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: weightOnePieceController,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
            onSubmitted?.call();
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Gramm/Stück'),
          validator: (value) {
            final trimmed = value?.trim() ?? '';
            if (trimmed.isEmpty) return null;

            final parsed = double.tryParse(trimmed.replaceAll(',', '.'));
            if (parsed == null) {
              return 'Bitte eine gültige Zahl eingeben';
            }
            if (parsed <= 0) {
              return 'Bitte > 0 eingeben';
            }

            return null;
          },
        ),
      ],
    );
  }
}
