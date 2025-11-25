import 'package:flutter/material.dart';

class MealDetailscreen extends StatelessWidget {
  const MealDetailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name der Mahlzeit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),),
          )
      );
  }
}