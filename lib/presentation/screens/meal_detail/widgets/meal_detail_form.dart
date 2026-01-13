import 'package:easy_carbs/app/theme/app_spacing.dart';
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
          MealImageSection(
            meal: widget.meal,
            mealId: widget.mealId,
          ),

//Location
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 100,
              ),
              child: IntrinsicWidth(
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    filled: false,
                    prefixIcon: const Icon(Icons.location_on),
                    hintText: 'Location',
                    contentPadding: const EdgeInsets.all(8),
                    ),
                  onChanged: notifier.updateLocation,
                ),
              ),
            ),
          ),

          const Divider( height: 8, thickness: 2,),
          const SizedBox(height: AppSpacing.spacingMd),

//PortionSize
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _portionSizeController,
                  keyboardType: TextInputType.number,
                  decoration:
                    const InputDecoration(hintText: '--'),
                  onChanged: (value) =>
                      notifier.updatePortionSize(double.tryParse(value)),
                ),
              ),
              const SizedBox(width: AppSpacing.spacingSm,),
            //TODO: In Portionseinheit ändern
            Text('Stück')
            ],
          ),
          
          const SizedBox(height: AppSpacing.spacingMd),

//BE Section
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
//Carbs In Unit
                child: TextField(
                  controller: _carbsInUnitController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: '--'),
                  onChanged: (value) =>
                    notifier.updateCarbsInUnit(double.tryParse(value)),
                ),
              ),
              const SizedBox(width: AppSpacing.spacingSm,),
//CarbUnit
            Text(
            widget.meal.carbUnit.name.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
            ],
          ),

          const SizedBox(height: AppSpacing.spacingXs),

//FPE Section
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
//FPE
                child: TextField(
                  controller: _fpeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '--'),
                    onChanged: (value) =>
                        notifier.updateFpe(double.tryParse(value)),
                ),
              ),
              const SizedBox(width: AppSpacing.spacingSm,),
//FPE-Einheit
            Text(
            'FPE',
            style: Theme.of(context).textTheme.titleMedium,
          ),
            ],
          ),

          const SizedBox(height: AppSpacing.spacingMd),
          

//Note
          TextField(
            controller: _noteController,
            maxLines: null,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Notizen...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              contentPadding: const EdgeInsets.all(12),
            ),
            onChanged: notifier.updateNote,
          ),

          const SizedBox(height: AppSpacing.spacingMd),

//Nutrition vorhanden Switch
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
