import 'package:easy_carbs/app/provider/tab_provider.dart';
import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/home/add_meal_button.dart';
//import 'package:easy_carbs/presentation/screens/home/db_viewer_button.dart';
import 'package:easy_carbs/presentation/screens/home/show_all_meals_button.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_list/widgets/meal_search_bar.dart';
import 'package:easy_carbs/presentation/screens/meal_list/widgets/meal_card.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Startseite der App mit Schnellaktionen und zuletzt angesehener Mahlzeit.
///
/// - Stellt Navigation/Shortcuts bereit (Suchen, alle Mahlzeiten, neue Mahlzeit).
/// - Zeigt optional die zuletzt angesehene Mahlzeit über [lastViewedMealIdProvider].
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastViewedId = ref.watch(lastViewedMealIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Have a nice Meal!"))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Oberer Inhalt
          Column(
            children: [
              //SearchBar
              MealSearchBar(
                onSubmitted: () {
                  ref.read(selectedTabProvider.notifier).setTab(1);
                },
              ),
              const SizedBox(height: AppSpacing.spacingLg),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    ShowAllMealsButton(),
                    SizedBox(width: AppSpacing.spacingXl),
                    //AddMeal Button
                    AddMealButton(),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.spacingLg),
              //DB Viewer -- Auskommentiert
              //Kommentar entfernen um die Datenbank einzusehen
              //const DbViewerButton(),
            ],
          ),

          // Unterer Bereich
          if (lastViewedId != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text + Separator in einer Zeile
                  Row(
                    children: [
                      Text(
                        "Zuletzt angesehen",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(child: Divider(thickness: 1.2)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ref
                      .watch(mealByIdProvider(lastViewedId))
                      .when(
                        loading: () => const CircularProgressIndicator(),
                        error: (e, _) => Text("Fehler: $e"),
                        data:
                            (meal) => MealCard(
                              meal: meal,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            MealDetailScreen(mealId: meal.id),
                                  ),
                                );
                              },
                            ),
                      ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
