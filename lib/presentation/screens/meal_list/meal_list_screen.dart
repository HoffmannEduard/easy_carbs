import 'dart:io';

import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/app/utils/format_extensions.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/visible_meal_provider.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListscreen extends ConsumerWidget {
  const MealListscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alle Mahlzeiten",),
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
                
                //Helper-Funktion für das Bild
                Widget mealImage(String imagePath) {
                  if (imagePath == AppAssets.defaultMealImagePath) {
                    return Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover,);
                  } else {
                    return Image.file(File(imagePath), width: 50, height: 50, fit: BoxFit.cover);
                  }
                }

              return ListTile(
                leading: mealImage(meal.imagePath),
                title: Text(meal.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (meal.location != null)
                      Text(meal.location!),
                    Text(
                      '${meal.carbsInUnit.to1dp()} ${meal.carbUnit.label}'
                      '${meal.fpe != null ? '  ●  ${meal.fpe!.to1dp()} FPE' : ''}'
                      '  ●  ${meal.portionsize} ${meal.portionUnit!.label}',
                    )
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
                  icon: const Icon(Icons.delete,)),
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