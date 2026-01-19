import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/add_nutrition/widgets/nutrition_fields_section.dart';
import 'package:easy_carbs/presentation/screens/add_nutrition/widgets/weight_per_piece_section.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';

class AddNutritionScreen extends ConsumerStatefulWidget {
  final String mealId;
  final Nutrition? existingNutrition;

  const AddNutritionScreen({
    super.key,
    required this.mealId,
    this.existingNutrition,
  });

  @override
  ConsumerState<AddNutritionScreen> createState() => _AddNutritionScreenState();
}

class _AddNutritionScreenState extends ConsumerState<AddNutritionScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _carbsController;
  late final TextEditingController _sugarController;
  late final TextEditingController _fatController;
  late final TextEditingController _saturatedFatController;
  late final TextEditingController _proteinController;
  late final TextEditingController _weightOnePieceController;

  @override
  void initState() {
    super.initState();

    _carbsController = TextEditingController(
      text: widget.existingNutrition?.carbs?.toString() ?? '',
    );
    _sugarController = TextEditingController(
      text: widget.existingNutrition?.sugar?.toString() ?? '',
    );
    _fatController = TextEditingController(
      text: widget.existingNutrition?.fat?.toString() ?? '',
    );
    _saturatedFatController = TextEditingController(
      text: widget.existingNutrition?.saturatedFat?.toString() ?? '',
    );
    _proteinController = TextEditingController(
      text: widget.existingNutrition?.protein?.toString() ?? '',
    );
    _weightOnePieceController = TextEditingController(
      text: widget.existingNutrition?.weightOnePiece.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _carbsController.dispose();
    _sugarController.dispose();
    _fatController.dispose();
    _saturatedFatController.dispose();
    _proteinController.dispose();
    _weightOnePieceController.dispose();
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
      id: widget.existingNutrition?.id,
      carbs: _parseDouble(_carbsController.text),
      sugar: _parseDouble(_sugarController.text),
      fat: _parseDouble(_fatController.text),
      saturatedFat: _parseDouble(_saturatedFatController.text),
      protein: _parseDouble(_proteinController.text),
      weightOnePiece: _parseDouble(_weightOnePieceController.text),
    );

    await ref
        .read(mealCommandsProvider(widget.mealId))
        .addOrUpdateNutrition(nutrition);

    await ref
        .read(calculateAutomaticallyUseCaseProvider)
        .setCarbsInUnitAndFpe(widget.mealId);

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingNutrition != null;
    final mealAsync = ref.watch(mealByIdProvider(widget.mealId));

    return mealAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (meal) {
        final showWeightPerPiece = meal.portionUnit == PortionUnit.piece;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEdit ? 'Nährwerte bearbeiten' : 'Nährwerte hinzufügen',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Felder für Nährwerte (Carbs, Fett, Protein...)
                  NutritionFieldsSection(
                    carbsController: _carbsController,
                    sugarController: _sugarController,
                    fatController: _fatController,
                    saturatedFatController: _saturatedFatController,
                    proteinController: _proteinController,
                  ),

                  const SizedBox(height: 16),

                  // Gewicht pro Stück Section
                  if (showWeightPerPiece)
                  WeightPerPieceSection(
                    weightOnePieceController: _weightOnePieceController,
                  ),

                  const SizedBox(height: AppSpacing.spacingXl),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _saveNutrition,
                        child: Text(isEdit ? 'Speichern' : 'Hinzufügen'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
