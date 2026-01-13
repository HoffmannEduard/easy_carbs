import 'package:flutter/material.dart';
class AppTheme {

  static const _seedColor = Color(0xFF8D6E63);
  static const _seedColorDarkMode = Colors.blueGrey;


// Light Mode
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light
      );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      //---AppBars---
      appBarTheme: AppBarTheme(
        elevation: 2.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: colorScheme.onPrimaryContainer
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimaryContainer)
      ),

      //---TextFields---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        prefixIconColor: colorScheme.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorScheme.onSurfaceVariant
        ),
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorScheme.onSurfaceVariant
        ),
      ),

      //---Elevated Buttons---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold
          )
        )
      ),

      //---Cards---
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
      )

    );
  }


// Dark Mode
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColorDarkMode,
      brightness: Brightness.dark
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      //---Hintergrund---
      scaffoldBackgroundColor: colorScheme.surfaceBright,
      
      
      //---AppBars---
      appBarTheme: AppBarTheme(
        elevation: 5.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: colorScheme.onPrimaryContainer
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimaryContainer)
      ),

      //---TextFields---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        prefixIconColor: colorScheme.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorScheme.onSurfaceVariant
        ),
        labelStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorScheme.onSurfaceVariant
        ),
      ),

      //---Elevated Buttons---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold
          )
        )
      ),

      //---Cards---
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
      )

    );
  }
}