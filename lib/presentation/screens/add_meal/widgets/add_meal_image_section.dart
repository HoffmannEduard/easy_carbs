import 'package:easy_carbs/presentation/screens/add_meal/widgets/meal_image_picker.dart';
import 'package:easy_carbs/presentation/state/meals/meal_image/add_meal_image_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// UI-Sektion zur Bildauswahl beim Anlegen einer Mahlzeit.
/// Verbindet den UI-Widget [MealImagePicker] mit dem Riverpod-State aus [addMealImageProvider].
class AddMealImageSection extends ConsumerWidget {
  const AddMealImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addMealImageProvider);
    final notifier = ref.read(addMealImageProvider.notifier);

    return MealImagePicker(
      image: state.image,
      onPickImage: (source) async {
        switch (source) {
          case ImageSource.camera:
            await notifier.pickFromCamera();
            break;
          case ImageSource.gallery:
            await notifier.pickFromGallery();
            break;
        }
      },
    );
  }
}
