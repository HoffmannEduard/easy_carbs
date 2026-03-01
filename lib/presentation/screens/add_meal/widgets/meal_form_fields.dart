import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';

/// Formularfelder zur Eingabe der Basisdaten einer Mahlzeit.
///
/// - Name (Pflichtfeld)
/// - Location (optional)
/// - PortionUnit-Auswahl (Pflichtfeld)
///
/// Validierungslogik ist direkt in den jeweiligen FormFields implementiert.
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
          key: const Key('addMeal_name_field'),
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
          key: const Key('addMeal_portionUnit_field'),
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
