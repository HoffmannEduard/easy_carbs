import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_and_sort_meal_view/visible_meal_provider.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
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
      body: ref.watch(visibleMealsProvider).when(
        data: (meals) {
          if (meals.isEmpty) {
            return const Center(child: Text('Noch keine Mahlzeiten'));
          }
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return ListTile(
                leading: Image.asset(meal.imagePath),
                title: Text(meal.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${meal.carbsInUnit} BE'),
                    if (meal.nutrition?.carbs != null)
                      Text('${meal.nutrition!.carbs} g Carbs')
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (_) => MealDetailScreen(mealId: meal.id)
                      )
                    );
                },
                trailing: IconButton(
                  onPressed: () async {
                    await ref.read(mealListNotifierProvider.notifier).deleteMeal(meal.id);
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