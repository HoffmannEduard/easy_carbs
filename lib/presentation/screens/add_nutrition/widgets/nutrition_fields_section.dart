import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:flutter/material.dart';

class NutritionFieldsSection extends StatelessWidget {
  final TextEditingController carbsController;
  final TextEditingController sugarController;
  final TextEditingController fatController;
  final TextEditingController saturatedFatController;
  final TextEditingController proteinController;
  final PortionUnit portionUnit;

  final FocusNode fatFocus;
  final FocusNode saturatedFatFocus;
  final FocusNode carbsFocus;
  final FocusNode sugarFocus;
  final FocusNode proteinFocus;

  /// Wenn gesetzt, springt "Protein" beim Submit in dieses Feld (z.B. Gewicht pro Stück).
  /// Wenn null, ist Protein das letzte Feld (DONE).
  final FocusNode? nextFocusAfterProtein;

  /// Wird aufgerufen wenn Protein das letzte Feld ist und der Nutzer DONE drückt.
  final VoidCallback? onDone;

  const NutritionFieldsSection({
    super.key,
    required this.carbsController,
    required this.sugarController,
    required this.fatController,
    required this.saturatedFatController,
    required this.proteinController,
    required this.portionUnit,
    required this.fatFocus,
    required this.saturatedFatFocus,
    required this.carbsFocus,
    required this.sugarFocus,
    required this.proteinFocus,
    this.nextFocusAfterProtein,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final header = portionUnit == PortionUnit.portion
        ? 'Nährwerte je Portion'
        : 'Nährwerte je 100 Gramm';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),

        // Fett
        TextFormField(
          controller: fatController,
          focusNode: fatFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(saturatedFatFocus),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Fett'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // gesättigte Fettsäuren
        TextFormField(
          controller: saturatedFatController,
          focusNode: saturatedFatFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(carbsFocus),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'ges. Fettsäuren'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // Kohlenhydrate (Pflichtfeld)
        TextFormField(
          controller: carbsController,
          focusNode: carbsFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(sugarFocus),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Kohlenhydrate'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Kohlenhydrate sind erforderlich';
            }
            if (double.tryParse(value.trim().replaceAll(',', '.')) == null) {
              return 'Bitte eine gültige Zahl eingeben';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Zucker
        TextFormField(
          controller: sugarController,
          focusNode: sugarFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(proteinFocus),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Zucker'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // Protein
        TextFormField(
          controller: proteinController,
          focusNode: proteinFocus,
          textInputAction: nextFocusAfterProtein != null ? TextInputAction.next : TextInputAction.done,
          onFieldSubmitted: (_) {
            if (nextFocusAfterProtein != null) {
              FocusScope.of(context).requestFocus(nextFocusAfterProtein);
              return;
            }
            FocusScope.of(context).unfocus();
            onDone?.call();
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Protein'),
          validator: _optionalNumberValidator,
        ),
      ],
    );
  }

  /// Optionales Zahlenfeld: leer erlaubt, sonst Zahl mit , oder .
  static String? _optionalNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    if (double.tryParse(value.trim().replaceAll(',', '.')) == null) {
      return 'Bitte eine gültige Zahl eingeben';
    }
    return null;
  }
}
