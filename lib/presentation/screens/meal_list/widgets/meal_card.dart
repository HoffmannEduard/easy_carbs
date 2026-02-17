import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/app/utils/format_extensions.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:flutter/material.dart';

/// Karten-Widget zur kompakten Darstellung einer Mahlzeit.
///
/// - Vorschaubild
/// - Name und optional Location
/// - BE/KE, optional FPE sowie Portionsangabe
class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onTap;

  const MealCard({
    super.key,
    required this.meal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 1,
      color: cs.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          leading: _MealThumbnail(imagePath: meal.imagePath),
          title: Text(meal.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (meal.location != null && meal.location!.isNotEmpty)
                Text(meal.location!),
              Text(
                '${meal.carbsInUnit.to1dp()} ${meal.carbUnit.label}'
                '${meal.fpe != null ? '  ●  ${meal.fpe!.to1dp()} FPE' : ''}'
                '  ●  ${meal.portionsize} ${meal.portionUnit!.label}',
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

/// Private helper widget: Thumbnail + Clip
class _MealThumbnail extends StatelessWidget {
  final String imagePath;

  const _MealThumbnail({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final Widget image = imagePath == AppAssets.defaultMealImagePath
        ? Image.asset(
            imagePath,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(imagePath),
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: image,
    );
  }
}
