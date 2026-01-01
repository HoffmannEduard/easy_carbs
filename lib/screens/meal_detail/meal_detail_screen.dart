import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailScreen extends ConsumerStatefulWidget {
  const MealDetailScreen({super.key});

  @override
  ConsumerState<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends ConsumerState<MealDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _carbsController = TextEditingController();
  final _nutritioncarbsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name der Mahlzeit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Bitte Namen eingeben' : null,
              ),
              TextFormField(
                controller: _carbsController,
                decoration: const InputDecoration(labelText: 'BE'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Bitte Carbs eingeben' : null,
              ),
              TextFormField(
                controller: _nutritioncarbsController,
                decoration: const InputDecoration(labelText: 'carbs'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Bitte Carbs eingeben' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final repo = ref.read(mealRepositoryProvider);
                    final meal = Meal(
                      name: _nameController.text,
                      carbUnit: CarbUnit.be,
                      carbsInUnit: double.parse(_carbsController.text),
                      nutrition: Nutrition(
                        carbs: double.parse(_nutritioncarbsController.text)
                      )
                    );
                    await repo.addMeal(meal);
                    Navigator.pop(context); // zurück zur Liste
                  }
                },
                child: const Text('Hinzufügen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _carbsController.dispose();
    super.dispose();
  }
}


