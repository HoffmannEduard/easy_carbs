import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Service zum Speichern und Löschen von Mahlzeitenbildern im App-Verzeichnis.
/// Bilder werden im Unterordner `meals` innerhalb des
/// Application Documents Directory abgelegt.
class MealImageService {

  /// Speichert ein ausgewähltes Bild dauerhaft im App-Verzeichnis.
  /// - Erstellt bei Bedarf den Ordner `meals`.
  /// - Vergibt einen eindeutigen Dateinamen (UUID).
  /// - Gibt den absoluten Dateipfad des gespeicherten Bildes zurück.
  Future<String> saveMealImage(XFile image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final mealsDir = Directory('${appDir.path}/meals');

      if (!await mealsDir.exists()) {
        await mealsDir.create(recursive: true);
      }

      final fileName = '${const Uuid().v4()}.jpg';
      final savedImage = await File(
        image.path,
      ).copy('${mealsDir.path}/$fileName');
      return savedImage.path;
    } catch (e) {
      return AppAssets.defaultMealImagePath;
    }
  }
  /// Löscht ein gespeichertes Mahlzeitenbild anhand des Dateipfads.
  Future<void> deleteMealImage(String? path) async {
    if (path == null || path == AppAssets.defaultMealImagePath) return;

    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
