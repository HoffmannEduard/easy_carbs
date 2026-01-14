import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail_notifier.dart';

class AddNutritionScreen extends ConsumerStatefulWidget {
  final String mealId;

  const AddNutritionScreen({
    super.key,
    required this.mealId,
  });

  @override
  ConsumerState<AddNutritionScreen> createState() =>
      _AddNutritionScreenState();
}

class _AddNutritionScreenState extends ConsumerState<AddNutritionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _carbsController = TextEditingController();
  final _sugarController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinController = TextEditingController();

  @override
  void dispose() {
    _carbsController.dispose();
    _sugarController.dispose();
    _fatController.dispose();
    _proteinController.dispose();
    super.dispose();
  }

  double? _parseDouble(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return double.tryParse(trimmed);
  }

  Future<void> _saveNutrition() async {
    if (!_formKey.currentState!.validate()) return;

    final nutrition = Nutrition(
      carbs: _parseDouble(_carbsController.text),
      sugar: _parseDouble(_sugarController.text),
      fat: _parseDouble(_fatController.text),
      protein: _parseDouble(_proteinController.text),
    );

    await ref
        .read(mealDetailNotifierProvider(widget.mealId).notifier)
        .addOrUpdateNutrition(nutrition);

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nährwerte hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
// --- Kohlenhydrate (Pflicht) ---
              TextFormField(
                controller: _carbsController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Kohlenhydrate (g)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kohlenhydrate sind erforderlich';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

// --- Zucker (optional) ---
              TextFormField(
                controller: _sugarController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Zucker (g)',
                ),
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

// --- Fett (optional) ---
              TextFormField(
                controller: _fatController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Fett (g)',
                ),
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

// --- Protein (optional) ---
              TextFormField(
                controller: _proteinController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Protein (g)',
                ),
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      double.tryParse(value) == null) {
                    return 'Bitte eine gültige Zahl eingeben';
                  }
                  return null;
                },
              ),

              const Spacer(),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _saveNutrition,
                  child: const Text('Speichern'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
