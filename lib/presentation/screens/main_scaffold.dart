import 'package:easy_carbs/app/provider/tab_provider.dart';
import 'package:easy_carbs/presentation/screens/home/home_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_list/meal_list_screen.dart';
import 'package:easy_carbs/presentation/screens/user_settings/user_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Zentrales Scaffold der App mit Bottom-Navigation.
///
/// - Home
/// - Mahlzeitenliste
/// - Benutzereinstellungen
///
/// Die Navigation wird über [selectedTabProvider] gesteuert.
/// Ein [IndexedStack] sorgt dafür, dass die einzelnen Screens ihren Zustand beim Tab-Wechsel behalten.
class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    final screens = const [
      HomeScreen(),
      MealListscreen(),
      UserSettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          FocusManager.instance.primaryFocus?.unfocus();
          ref.read(selectedTabProvider.notifier).setTab(index);
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
