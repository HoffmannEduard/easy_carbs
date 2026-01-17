import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/meal_image_section.dart';
import 'package:easy_carbs/presentation/state/meals/meal_image/meal_image_action_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HandleMealDetailImage extends ConsumerWidget {
  const HandleMealDetailImage({
    super.key,
    required this.meal,
    required this.mealId,
  });

  final Meal meal;
  final String mealId;

  Future<String?> showMealImageOptions(
  BuildContext context,
  bool hasCustomImage,
) {
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
              iconColor: Colors.red,
              textColor: Colors.red,
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

Future<bool?> confirmDeleteMealImage(
  BuildContext context,
) {
  return showDialog<bool>(
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
          child: const Text('Löschen',
          style: TextStyle(
            color: Colors.red
          ),),
        ),
      ],
    ),
  );
}



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(mealImageActionProvider(mealId));
    final notifier =
        ref.read(mealImageActionProvider(mealId).notifier);

    ref.listen(
      mealImageActionProvider(mealId),
      (prev, next) {
        if (next.error != null &&
            next.error != prev?.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error!)),
          );
        }
      },
    );

    return MealImageSection(
      imagePath: meal.imagePath,
      onTap: state.isBusy
          ? null
          : () async {
              final action =
                  await showMealImageOptions(
                    context,
                    meal.imagePath !=
                        AppAssets.defaultMealImagePath,
                  );

              if (action == null) return;

              switch (action) {
                case 'gallery':
                  notifier.pickFromGallery();
                  break;
                case 'camera':
                  notifier.pickFromCamera();
                  break;
                case 'delete':
                  final confirmed =
                      await confirmDeleteMealImage(context);
                  if (confirmed == true) {
                    notifier.deleteImage();
                  }
                  break;
              }
            },
    );
  }
}
