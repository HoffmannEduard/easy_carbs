import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class MealImageService {

  // Bild speichern + Pfad zurückgeben
  Future<String> saveMealImage(XFile image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final mealsDir = Directory('${appDir.path}/meals');

      if (!await mealsDir.exists()) {
        await mealsDir.create(recursive: true);
      }

      final fileName = '${const Uuid().v4()}.jpg';
      final savedImage = await File(image.path).copy('${mealsDir.path}/$fileName');

      return savedImage.path;
    } catch (e) {
      // Fallback: default Asset
      return AppAssets.defaultMealImagePath;
    }
  }
}
