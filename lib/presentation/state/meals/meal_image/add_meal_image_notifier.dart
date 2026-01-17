import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'add_meal_image_state.dart';

class AddMealImageNotifier extends Notifier<AddMealImageState> {
  final ImagePicker _picker = ImagePicker();

  @override
  AddMealImageState build() {
    return const AddMealImageState();
  }

  Future<void> pickFromGallery() async {
    await _pick(ImageSource.gallery);
  }

  Future<void> pickFromCamera() async {
    await _pick(ImageSource.camera);
  }

  Future<void> _pick(ImageSource source) async {
    state = state.copyWith(isPicking: true, error: null);

    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (picked != null) {
        state = state.copyWith(image: picked);
      }

      state = state.copyWith(isPicking: false);
    } catch (e) {
      state = state.copyWith(
        isPicking: false,
        error: e.toString(),
      );
    }
  }
}

final addMealImageProvider =
    NotifierProvider.autoDispose<AddMealImageNotifier, AddMealImageState>(
  AddMealImageNotifier.new,
);

