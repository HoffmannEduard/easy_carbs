import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailScreen extends ConsumerStatefulWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  ConsumerState<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends ConsumerState<MealDetailScreen> {
  final _carbsController = TextEditingController();
  final _fpeController = TextEditingController();
  final _locationController = TextEditingController();
  final _portionSizeController = TextEditingController();
  final _noteController = TextEditingController();

  bool _initialized = false;

  void _initControllers(Meal meal) {
    if (_initialized) return;

    _carbsController.text = meal.carbsInUnit?.toString() ?? '';
    _fpeController.text = meal.fpe?.toString() ?? '';
    _locationController.text = meal.location ?? '';
    _portionSizeController.text = meal.portionsize?.toString() ?? '';
    _noteController.text = meal.note ?? '';

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final mealAsync =
        ref.watch(mealDetailNotifierProvider(widget.mealId));

    return Scaffold(
        appBar: AppBar(
          title: mealAsync.when(
          loading: () => const Text('Lade Mahlzeit…'),
          error: (_, __) => const Text('Fehler'),
          data: (meal) => Text(
            meal.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),

      body: mealAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (meal) {
          _initControllers(meal);
          final notifier =
              ref.read(mealDetailNotifierProvider(widget.mealId).notifier);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [

                //Location
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Ort'),
                  onChanged: notifier.updateLocation,
                ),

                // CarbUnit (read-only)
                Text(
                  'Carb Unit: ${meal.carbUnit.name}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                //Portionsgröße
                TextField(
                  controller: _portionSizeController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Portionsgröße'),
                  onChanged: (v) => notifier.updatePortionSize(
                    double.tryParse(v),
                  ),
                ),

                const SizedBox(height: 16),
                //Carbs in Unit
                TextField(
                  controller: _carbsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Carbs in Unit'),
                  onChanged: (v) => notifier.updateCarbsInUnit(
                    double.tryParse(v),
                  ),
                ),

                //FPE
                TextField(
                  controller: _fpeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'FPE'),
                  onChanged: (v) => notifier.updateFpe(
                    double.tryParse(v),
                  ),
                ),

                //Notiz
                TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(labelText: 'Notiz'),
                  onChanged: notifier.updateNote,
                ),

                //Nutrition
                SwitchListTile(
                  title: const Text('Nutrition vorhanden'),
                  value: meal.nutrition != null,
                  onChanged: (value) {
                    if (!value) notifier.removeNutrition();
                    // Hinzufügen passiert über separaten Dialog
                  },
                ),

                

                

              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _carbsController.dispose();
    _fpeController.dispose();
    _locationController.dispose();
    _portionSizeController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
