import 'package:flutter/material.dart';

class MealListscreen extends StatelessWidget {
  const MealListscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alle Mahlzeiten",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          )
      );
  }
}