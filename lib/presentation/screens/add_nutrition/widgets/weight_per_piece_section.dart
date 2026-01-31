import 'package:flutter/material.dart';

class WeightPerPieceSection extends StatelessWidget {
  final TextEditingController weightOnePieceController;

  const WeightPerPieceSection({
    super.key,
    required this.weightOnePieceController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Gewicht je Stück in Gramm',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: weightOnePieceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Gramm/Stück'),
          validator: (value) {
            if (value != null &&
                value.trim().isNotEmpty &&
                double.tryParse(value) == null) {
              return 'Bitte eine gültige Zahl eingeben';
            }
            return null;
          },
        ),
      ],
    );
  }
}
