
import 'package:easy_carbs/presentation/screens/home/home_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/screens/user_settings/user_settings_screen.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {

  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

@override
void initState() {
  super.initState();
  _screens = [
    HomeScreen(),
    MealListscreen(),
    UserSettingsScreen()
  ];
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.fastfood), label: 'Meals'),
          NavigationDestination(icon: Icon(Icons.account_circle), label: 'Profil'),
        ],
      ),
      );
  }
}