import 'package:easy_carbs/app/provider/tab_provider.dart';
import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/home/add_meal_button.dart';
import 'package:easy_carbs/presentation/screens/home/db_viewer_button.dart';
import 'package:easy_carbs/presentation/screens/home/show_all_meals_button.dart';
import 'package:easy_carbs/presentation/screens/meal_list/widgets/meal_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Have a nice Meal!"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MealSearchBar(
              onSubmitted: () {
                ref.read(selectedTabProvider.notifier).setTab(1);
              },
            ),
            SizedBox(height: AppSpacing.spacingLg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowAllMealsButton(),
                  SizedBox(width: AppSpacing.spacingXl),
                  AddMealButton(),
                ],
              ),
            ),
            //Database nur für Testzwecke
            SizedBox(height: AppSpacing.spacingLg),
            SizedBox(height: AppSpacing.spacingLg),
            DbViewerButton(),
          ],
        ),
      ),
    );
  }
}
