import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_list/widgets/meal_card.dart';
import 'package:easy_carbs/presentation/screens/meal_list/widgets/meal_search_bar.dart';
import 'package:easy_carbs/presentation/state/meals/filter_meal_view/visible_meal_provider.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen zur Anzeige aller gespeicherten Mahlzeiten.
///
/// - Verwendet [visibleMealsProvider] zur Kombination aus Mahlzeiten-Stream und aktivem Suchfilter.
/// - Navigiert bei Auswahl einer Mahlzeit zum [MealDetailScreen].
/// - Speichert die zuletzt angesehene Mahlzeit über [lastViewedMealIdProvider].
class MealListscreen extends ConsumerWidget {
  const MealListscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Alle Mahlzeiten")),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            const MealSearchBar(),
            Expanded(
              child: ref
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

                          return MealCard(
                            meal: meal,
                            onTap: () {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (_) => MealDetailScreen(mealId: meal.id))
                              );
                              ref.read(lastViewedMealIdProvider.notifier).state = meal.id;
                            },
                            );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text('Fehler: $error')),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
