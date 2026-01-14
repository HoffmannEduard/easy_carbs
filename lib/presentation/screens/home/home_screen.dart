import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/home/add_meal_button.dart';
import 'package:easy_carbs/presentation/screens/home/db_viewer_button.dart';
import 'package:easy_carbs/presentation/screens/home/search_meal_card.dart';
import 'package:easy_carbs/presentation/screens/home/show_all_meals_button.dart';
import 'package:easy_carbs/presentation/screens/user_settings/user_settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("EasyCarbs",
          )),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => UserSettingsScreen())
                );
              }, 
              icon: const Icon(Icons.account_circle)
              ),
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchMealCard(),
              SizedBox(height: AppSpacing.spacingLg), 
              ShowAllMealsButton(),
              SizedBox(height: AppSpacing.spacingLg), 
              AddMealButton(),
              //Database nur für Testzwecke
              SizedBox(height: AppSpacing.spacingLg),
              SizedBox(height: AppSpacing.spacingLg),
              DbViewerButton()
            ],
          ),
        ),
      ),
    );
  }
}
