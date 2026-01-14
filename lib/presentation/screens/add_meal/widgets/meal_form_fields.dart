import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';

class MealFormFields extends StatelessWidget {
  const MealFormFields({
    super.key,
    required this.nameController,
    required this.locationController,
    required this.portionUnit,
    required this.onPortionUnitChanged,
  });

  final TextEditingController nameController;
  final TextEditingController locationController;
  final PortionUnit? portionUnit;
  final ValueChanged<PortionUnit?> onPortionUnitChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
// --- Name ---
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name ist erforderlich';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

// --- Location ---
        TextFormField(
          controller: locationController,
          decoration: const InputDecoration(
            hintText: 'Location',
          ),
        ),

        const SizedBox(height: 32),

// --- PortionUnit ---
        DropdownButtonFormField<PortionUnit>(
          value: portionUnit,
          hint: const Text('Einheit wählen'),
          items: const [
            DropdownMenuItem(
              value: PortionUnit.portion,
              child: Text('Portion'),
            ),
            DropdownMenuItem(
              value: PortionUnit.gramm,
              child: Text('Gewicht'),
            ),
            DropdownMenuItem(
              value: PortionUnit.piece,
              child: Text('Stück'),
            ),
          ],
          onChanged: onPortionUnitChanged,
          validator: (value) {
            if (value == null) {
              return 'Bitte eine Einheit auswählen';
            }
            return null;
          },
        ),
      ],
    );
  }
}
