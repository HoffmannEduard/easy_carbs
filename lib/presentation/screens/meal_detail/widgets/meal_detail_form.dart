import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meal_image_section.dart';

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
  final _carbsController = TextEditingController();
  final _fpeController = TextEditingController();
  final _locationController = TextEditingController();
  final _portionSizeController = TextEditingController();
  final _noteController = TextEditingController();

  bool _controllersInitialized = false;

  void _initControllers(Meal meal) {
    if (_controllersInitialized) return;

    _carbsController.text = meal.carbsInUnit?.toString() ?? '';
    _fpeController.text = meal.fpe?.toString() ?? '';
    _locationController.text = meal.location ?? '';
    _portionSizeController.text = meal.portionsize?.toString() ?? '';
    _noteController.text = meal.note ?? '';

    _controllersInitialized = true;
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

  @override
  Widget build(BuildContext context) {
    final notifier =
        ref.read(mealDetailNotifierProvider(widget.mealId).notifier);

    _initControllers(widget.meal);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          MealImageSection(
            meal: widget.meal,
            mealId: widget.mealId,
          ),

          TextField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: 'Ort'),
            onChanged: notifier.updateLocation,
          ),

          const SizedBox(height: 12),

          Text(
            'Carb Unit: ${widget.meal.carbUnit.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          TextField(
            controller: _portionSizeController,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Portionsgröße'),
            onChanged: (value) =>
                notifier.updatePortionSize(double.tryParse(value)),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _carbsController,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Carbs in Unit'),
            onChanged: (value) =>
                notifier.updateCarbsInUnit(double.tryParse(value)),
          ),

          TextField(
            controller: _fpeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'FPE'),
            onChanged: (value) =>
                notifier.updateFpe(double.tryParse(value)),
          ),

          TextField(
            controller: _noteController,
            decoration: const InputDecoration(labelText: 'Notiz'),
            onChanged: notifier.updateNote,
          ),

          const SizedBox(height: 12),

          SwitchListTile(
            title: const Text('Nutrition vorhanden'),
            value: widget.meal.nutrition != null,
            onChanged: (value) {
              if (!value) notifier.removeNutrition();
            },
          ),
        ],
      ),
    );
  }
}
