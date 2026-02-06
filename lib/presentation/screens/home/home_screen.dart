import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/home/add_meal_button.dart';
import 'package:easy_carbs/presentation/screens/home/db_viewer_button.dart';
import 'package:easy_carbs/presentation/screens/home/search_meal_card.dart';
import 'package:easy_carbs/presentation/screens/home/show_all_meals_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Have a nice Meal!"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchMealCard(),
              SizedBox(height: AppSpacing.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowAllMealsButton(),
                  SizedBox(width: AppSpacing.spacingXl),
                  AddMealButton(),
                ],
              ),
              //Database nur für Testzwecke
              SizedBox(height: AppSpacing.spacingLg),
              SizedBox(height: AppSpacing.spacingLg),
              DbViewerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
