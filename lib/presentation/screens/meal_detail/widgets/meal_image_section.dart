import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:flutter/material.dart';

class MealImageSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const MealImageSection({
    super.key,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDefault = imagePath == AppAssets.defaultMealImagePath;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: double.infinity,
            height: 250,
            child: isDefault
                ? Image.asset(
                    AppAssets.defaultMealImagePath,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
