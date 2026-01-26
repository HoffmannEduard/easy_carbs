import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/app/utils/format_extensions.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/add_nutrition/add_nutrition_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/auto_calculate_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/be_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/fpe_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/handle_meal_detail_image.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/location_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/note_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/nutrition_section.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/portion_size_section.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailScreen extends ConsumerStatefulWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  ConsumerState<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends ConsumerState<MealDetailScreen> {
  final _carbsInUnitController = TextEditingController();
  final _fpeController = TextEditingController();
  final _locationController = TextEditingController();
  final _portionSizeController = TextEditingController();
  final _noteController = TextEditingController();

  bool _controllersInitialized = false;

  void _initControllers(Meal meal) {
    if (_controllersInitialized) return;

    if (!meal.autocalculate) {
    _carbsInUnitController.text = meal.carbsInUnit.to1dp();
    _fpeController.text = meal.fpe.to1dp();
    }
    _locationController.text = meal.location ?? '';
    _portionSizeController.text = meal.portionsize.to1dp();
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
    final mealAsync = ref.watch(mealByIdProvider(widget.mealId));
    final commands = ref.read(mealCommandsProvider(widget.mealId));
    final autocalc = ref.read(calculateAutomaticallyUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: mealAsync.when(
          loading: () => const Text('Lade Mahlzeit…'),
          error: (_, __) => const Text('Fehler'),
          data: (meal) => Text(meal.name),
        ),
      ),
      body: mealAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (meal) {
          _initControllers(meal);
          if (meal.autocalculate) {
            _carbsInUnitController.text = meal.carbsInUnit.to1dp();
            _fpeController.text = meal.fpe.to1dp();
          }

          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [

// Image
                  HandleMealDetailImage(meal: meal, mealId: widget.mealId),


// Location
                  LocationSection(
                    controller: _locationController,
                    onCommit: commands.updateLocation,
                  ),
                  const Divider(height: 8, thickness: 2),
                  const SizedBox(height: AppSpacing.spacingMd),


// PortionSize
                  PortionSizeSection(
                    controller: _portionSizeController,
                    unitLabel: meal.portionUnit!.label,
                    onCommit: (value) async {
                    await commands.updatePortionSize(value);
                      if (value == 0) {
                        await commands.toggleAutocalculate(false);
                      }
                      if (meal.autocalculate) {
                    await autocalc.setCarbsInUnitAndFpe(widget.mealId);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.spacingMd),


// Autocalculate Switch
                  AutoCalculateSection(
                    meal: meal, 
                    onToggleAutocalculate: (value) =>
                      commands.toggleAutocalculate(value), 
                    onRunAutocalc: () =>
                      autocalc.setCarbsInUnitAndFpe(widget.mealId)
                    ),
                  const SizedBox(height: AppSpacing.spacingMd),


// BE/KE
                  BESection(
                    controller: _carbsInUnitController,
                    readonly: meal.autocalculate,
                    unitLabel: meal.carbUnit.name.toUpperCase(),
                    onCommit: commands.updateCarbsInUnit,
                  ),
                  const SizedBox(height: AppSpacing.spacingXs),


// FPE
                  FPESection(
                    controller: _fpeController,
                    readonly: meal.autocalculate,
                    onCommit: commands.updateFpe,
                  ),
                  const SizedBox(height: AppSpacing.spacingMd),


// Note
                  NoteSection(
                    controller: _noteController,
                    onChanged: commands.updateNote,
                  ),
                  const SizedBox(height: AppSpacing.spacingMd),


// Nutrition
                  NutritionSection(
                    nutrition: meal.nutrition,
                    onAdd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => AddNutritionScreen(mealId: widget.mealId),
                        ),
                      );
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => AddNutritionScreen(
                                mealId: widget.mealId,
                                existingNutrition: meal.nutrition,
                              ),
                        ),
                      );
                    },
                    onDelete: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Nährwerte löschen?'),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text('Abbrechen'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text(
                                    'Löschen',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                      );

                      if (confirm == true) {
                        if (meal.autocalculate) {
                          commands.toggleAutocalculate(false);
                        }
                        await commands.removeNutrition();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
