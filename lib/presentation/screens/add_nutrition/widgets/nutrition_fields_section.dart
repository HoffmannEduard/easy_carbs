import 'package:flutter/material.dart';

class NutritionFieldsSection extends StatelessWidget {
  final TextEditingController carbsController;
  final TextEditingController sugarController;
  final TextEditingController fatController;
  final TextEditingController saturatedFatController;
  final TextEditingController proteinController;

  const NutritionFieldsSection({
    super.key,
    required this.carbsController,
    required this.sugarController,
    required this.fatController,
    required this.saturatedFatController,
    required this.proteinController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nährwerte je 100 Gramm',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),

        // Fett
        TextFormField(
          controller: fatController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Fett'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // gesättigte Fettsäuren
        TextFormField(
          controller: saturatedFatController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'ges. Fettsäuren'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // Kohlenhydrate (Pflichtfeld)
        TextFormField(
          controller: carbsController,
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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Zucker'),
          validator: _optionalNumberValidator,
        ),

        const SizedBox(height: 16),

        // Protein
        TextFormField(
          controller: proteinController,
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
