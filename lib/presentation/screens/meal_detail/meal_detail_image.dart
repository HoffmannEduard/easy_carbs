import 'dart:io';
import 'package:flutter/material.dart';

class MealDetailImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const MealDetailImage({
    super.key,
    required this.imagePath,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('assets/')) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
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
