import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/add_nutrition/add_nutrition_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/be_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/fpe_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/location_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/note_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/nutrition_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/portion_size_section.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'handle_meal_detail_image.dart';

class MealDetailForm extends ConsumerStatefulWidget {
  final Meal meal;
  final String mealId;

  const MealDetailForm({
    super.key,
    required this.meal,
    required this.mealId,
  });

  @override
  ConsumerState<MealDetailForm> createState() => _MealDetailFormState();
}

class _MealDetailFormState extends ConsumerState<MealDetailForm> {
  final _carbsInUnitController = TextEditingController();
  final _fpeController = TextEditingController();
  final _locationController = TextEditingController();
  final _portionSizeController = TextEditingController();
  final _noteController = TextEditingController();

  bool _controllersInitialized = false;

  void _initControllers(Meal meal) {
    if (_controllersInitialized) return;

    _carbsInUnitController.text = meal.carbsInUnit?.toString() ?? '';
    _fpeController.text = meal.fpe?.toString() ?? '';
    _locationController.text = meal.location ?? '';
    _portionSizeController.text = meal.portionsize?.toString() ?? '';
    _noteController.text = meal.note ?? '';

    _controllersInitialized = true;
  }

  @override
  void dispose() {
    _carbsInUnitController.dispose();
    _fpeController.dispose();
    _locationController.dispose();
    _portionSizeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier =
        ref.read(mealDetailNotifierProvider(widget.mealId).notifier);

    _initControllers(widget.meal);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
//Image          
          HandleMealDetailImage(
            meal: widget.meal,
            mealId: widget.mealId,
          ),
//Location
          LocationSection(
            controller: _locationController,
            onChanged: notifier.updateLocation,
          ),

          const Divider(height: 8, thickness: 2),
          const SizedBox(height: AppSpacing.spacingMd),
//PortionSize Section
          PortionSizeSection(
            controller: _portionSizeController,
            unitLabel: widget.meal.portionUnit!.label,
            onChanged: notifier.updatePortionSize,
          ),

          const SizedBox(height: AppSpacing.spacingMd),
//BE Section
          BESection(
            controller: _carbsInUnitController,
            unitLabel: widget.meal.carbUnit.name.toUpperCase(),
            onChanged: notifier.updateCarbsInUnit,
          ),

          const SizedBox(height: AppSpacing.spacingXs),
//FPE Section
          FPESection(
            controller: _fpeController,
            onChanged: notifier.updateFpe,
          ),

          const SizedBox(height: AppSpacing.spacingMd),
//Note Section
          NoteSection(
            controller: _noteController,
            onChanged: notifier.updateNote,
          ),

          const SizedBox(height: AppSpacing.spacingMd),

// Nutrition Section
            if (widget.meal.nutrition == null)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddNutritionScreen(mealId: widget.mealId),
                      ),
                    );
                  },
                  child: const Text('Nährwerte hinzufügen'),
                ),
              )
            else
              NutritionSection(
                nutrition: widget.meal.nutrition!,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddNutritionScreen(
                        mealId: widget.mealId,
                        existingNutrition: widget.meal.nutrition,
                      ),
                    ),
                  );
                },
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Nährwerte löschen?'),
                      content: const Text('Diese Aktion kann nicht rückgängig gemacht werden.'),
                      actions: [
                        TextButton(child: const Text('Abbrechen'), onPressed: () => Navigator.pop(context, false)),
                        TextButton(child: const Text('Löschen'), onPressed: () => Navigator.pop(context, true)),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await notifier.removeNutrition(); // **UI rebuildt automatisch**
                  }
                },
              ),
        ],
      ),
    );
  }
}
