import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/add_meal/widgets/meal_form_fields.dart';
import 'package:easy_carbs/presentation/state/meals/meal_image/add_meal_image_notifier.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:easy_carbs/presentation/screens/add_meal/widgets/add_meal_image_section.dart';

/// Screen zum Anlegen einer neuen Mahlzeit.
///
/// Enthält ein Formular für Basisdaten (Name, Ort, Portionseinheit) sowie
/// eine optionale Bildauswahl. Das Speichern erfolgt über [MealListNotifier].
class AddMealScreen extends ConsumerStatefulWidget {
  const AddMealScreen({super.key});

  @override
  ConsumerState<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends ConsumerState<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  PortionUnit? _portionUnit;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// Validiert das Formular, legt die Mahlzeit an und navigiert zur Detailansicht.
  /// - Optionales Bild wird aus [addMealImageProvider] übernommen.
  /// - Bei Erfolg: `pushReplacement` zur [MealDetailScreen] und Setzen von [lastViewedMealIdProvider] für Startseite.
  /// - Bei Fehler: SnackBar als Nutzerfeedback.
  Future<void> _createMeal() async {
    if (!_formKey.currentState!.validate() || _portionUnit == null) return;

    final imageState = ref.read(addMealImageProvider);
    final image = imageState.image;

    try {
      final mealId = await ref
          .read(mealListNotifierProvider.notifier)
          .createMeal(
            name: _nameController.text.trim(),
            location: _locationController.text.trim().isEmpty
                ? null
                : _locationController.text.trim(),
            imageFile: image,
            portionUnit: _portionUnit!,
          );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MealDetailScreen(mealId: mealId),
        ),
      );
      ref.read(lastViewedMealIdProvider.notifier).state = mealId;
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mahlzeit konnte nicht gespeichert werden'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Mahlzeit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Image ---
                const AddMealImageSection(),

                const SizedBox(height: 24),

                MealFormFields(
                  nameController: _nameController,
                  locationController: _locationController,
                  portionUnit: _portionUnit,
                  onPortionUnitChanged: (value) {
                    setState(() {
                      _portionUnit = value;
                    });
                  },
                ),

                const SizedBox(height: 32),

                // --- Erstellen Button ---
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('addMeal_create_button'),
                    onPressed: _createMeal,
                    child: const Text('Erstellen'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
