import 'package:easy_carbs/presentation/screens/user_settings/us_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSettingsScreen extends ConsumerWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Startseite",
        ),
      ),
      body: Center(child: UsInputWidget()),
    );
  }
}
