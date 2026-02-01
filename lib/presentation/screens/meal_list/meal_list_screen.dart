import 'dart:io';

import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/app/utils/format_extensions.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/visible_meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealListscreen extends ConsumerWidget {
  const MealListscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Alle Mahlzeiten")),
      body: ref
          .watch(visibleMealsProvider)
          .when(
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
                    final image =
                        imagePath == AppAssets.defaultMealImagePath
                            ? Image.asset(
                              imagePath,
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            )
                            : Image.file(
                              File(imagePath),
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            );

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8), 
                      child: image,
                    );
                  }

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    elevation: 1,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: mealImage(meal.imagePath),
                        title: Text(meal.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (meal.location != null) Text(meal.location!),
                            Text(
                              '${meal.carbsInUnit.to1dp()} ${meal.carbUnit.label}'
                              '${meal.fpe != null ? '  ●  ${meal.fpe!.to1dp()} FPE' : ''}'
                              '  ●  ${meal.portionsize} ${meal.portionUnit!.label}',
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealDetailScreen(mealId: meal.id),
                            ),
                          );
                        },
                      ),
                    ),
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
