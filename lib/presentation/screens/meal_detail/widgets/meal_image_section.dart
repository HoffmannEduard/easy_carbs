import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:flutter/material.dart';

/// Anzeige des Mahlzeitenbildes in der Detailansicht.
///
/// - Zeigt entweder das Default-Asset oder ein gespeichertes Dateibild.
/// - Optional klickbar über [onTap].
class MealImageSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const MealImageSection({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDefault = imagePath == AppAssets.defaultMealImagePath;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 350, 
              minHeight: 220,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth, 
                alignment: Alignment.center, 
                clipBehavior: Clip.hardEdge,
                child:
                    isDefault
                        ? Image.asset(AppAssets.defaultMealImagePath)
                        : Image.file(File(imagePath)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
