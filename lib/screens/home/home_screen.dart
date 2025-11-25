import 'package:easy_carbs/screens/home/add_meal_button.dart';
import 'package:easy_carbs/screens/home/search_meal_card.dart';
import 'package:easy_carbs/screens/home/show_all_meals_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("EasyCarbs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchMealCard(),
              SizedBox(height: 24), 
              ShowAllMealsButton(),
              SizedBox(height: 24), 
              AddMealButton()
            ],
          ),
        ),
      ),
    );
  }
}






