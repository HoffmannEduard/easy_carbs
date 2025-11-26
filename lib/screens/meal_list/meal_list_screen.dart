import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListscreen extends ConsumerWidget {
  const MealListscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alle Mahlzeiten",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          ),
      body: ref.watch(mealsStreamProvider).when(
        data: (meals) {
          if (meals.isEmpty) {
            return const Center(child: Text('Noch keine Mahlzeiten'));
          }
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return ListTile(
                leading: Image.asset(meal.imagePath!),
                title: Text(meal.name),
                subtitle: Text('${meal.carbs} g carbs'),
                trailing: IconButton(
                  onPressed: () async {
                    final repo = ref.read(mealRepositoryProvider);
                    await repo.deleteMeal(meal.id);
                  }, 
                  icon: const Icon(Icons.delete, color: Colors.red,)),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Fehler: $error')),
      ),
      );
  }
}