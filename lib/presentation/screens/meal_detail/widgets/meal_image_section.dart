import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/meal_detail_image.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MealImageSection extends ConsumerStatefulWidget {
  final Meal meal;
  final String mealId;

  const MealImageSection({
    super.key,
    required this.meal,
    required this.mealId,
  });

  @override
  ConsumerState<MealImageSection> createState() =>
      _MealImageSectionState();
}

class _MealImageSectionState
    extends ConsumerState<MealImageSection> {
  static const _defaultImage = AppAssets.defaultMealImagePath;

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MealDetailImage(
      imagePath: widget.meal.imagePath,
      onTap: _handleImageTap,
    );
  }

  Future<void> _handleImageTap() async {
    final action = await _showImageOptions();
    if (!mounted || action == null) return;

    final notifier = ref.read(
      mealDetailNotifierProvider(widget.mealId).notifier,
    );

    if (action == 'gallery' || action == 'camera') {
      final picked = await _picker.pickImage(
        source: action == 'gallery'
            ? ImageSource.gallery
            : ImageSource.camera,
        imageQuality: 85,
      );
      if (!mounted) return;

      if (picked != null) {
        await notifier.updateImageFromFile(picked);
      }
    }

    if (action == 'delete') {
      await _confirmDelete(notifier);
    }
  }

  Future<String?> _showImageOptions() {
    final hasCustomImage =
        widget.meal.imagePath != _defaultImage;

    return showModalBottomSheet<String>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Galerie'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            if (hasCustomImage)
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Löschen'),
                onTap: () => Navigator.pop(context, 'delete'),
              ),
            ListTile(
              title: const Text('Abbrechen'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    MealDetailNotifier notifier,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Foto wirklich löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirmed == true) {
      await notifier.removeImage();
    }
  }
}
