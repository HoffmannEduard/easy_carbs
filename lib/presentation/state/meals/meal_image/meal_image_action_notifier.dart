import 'package:easy_carbs/domain/usecases/meals/meal_commands_use_case.dart';
import 'package:easy_carbs/presentation/state/meals/meal_image/meal_image_action_state.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Notifier für Bildaktionen einer bestehenden Mahlzeit.
/// Kapselt:
/// - Auswahl eines neuen Bildes (Galerie/Kamera)
/// - Löschen des aktuellen Bildes
/// - Fehler- und Busy-Zustand
class MealImageActionNotifier extends Notifier<MealImageActionState> {
  MealImageActionNotifier(this.mealId);

  final String mealId;

  late final MealCommandsUseCase _commands;
  late final ImagePicker _picker;

  @override
  MealImageActionState build() {
    _commands = ref.read(mealCommandsProvider(mealId));
    _picker = ImagePicker();

    return const MealImageActionState();
  }

  Future<void> pickFromGallery() async {
    await _pick(ImageSource.gallery);
  }

  Future<void> pickFromCamera() async {
    await _pick(ImageSource.camera);
  }

  /// Entfernt das aktuelle Bild der Mahlzeit.
  /// Setzt bei Erfolg den Zustand zurück,
  Future<void> deleteImage() async {
    state = state.copyWith(isBusy: true, error: null);

    try {
      await _commands.removeImage();
      state = const MealImageActionState();
    } catch (e) {
      state = MealImageActionState(error: e.toString());
    }
  }


  /// Methode zur Bildauswahl und Aktualisierung.
  /// - Setzt `isBusy` während der Verarbeitung.
  /// - Skaliert das Bild (max. 1024px, Qualität 70).
  /// - Aktualisiert die Mahlzeit über [MealCommandsUseCase].
  Future<void> _pick(ImageSource source) async {
    state = state.copyWith(isBusy: true, error: null);

    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxHeight: 1024,
        maxWidth: 1024,
      );

      if (picked != null) {
        await _commands.updateImageFromFile(picked);
      }

      state = const MealImageActionState();
    } catch (e) {
      state = MealImageActionState(error: e.toString());
    }
  }
}


final mealImageActionProvider = NotifierProvider.family<
MealImageActionNotifier,
    MealImageActionState,
    String>(
  MealImageActionNotifier.new,
);
