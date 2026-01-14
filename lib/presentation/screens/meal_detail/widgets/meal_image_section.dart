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
          child: isDefault
              ? SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: null, // noch kein onTap, nur Optik
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[800],
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add_a_photo, size: 28),
                    label: const Text(
                      'Foto hinzufügen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : Image.file(
                  File(imagePath),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
