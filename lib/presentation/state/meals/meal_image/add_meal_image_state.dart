import 'package:image_picker/image_picker.dart';

/// Zustand für die Bildauswahl beim Anlegen einer Mahlzeit.
class AddMealImageState {
  final XFile? image;
  final bool isPicking;
  final String? error;

  const AddMealImageState({
    this.image,
    this.isPicking = false,
    this.error,
  });

  AddMealImageState copyWith({
    XFile? image,
    bool? isPicking,
    String? error,
  }) {
    return AddMealImageState(
      image: image ?? this.image,
      isPicking: isPicking ?? this.isPicking,
      error: error,
    );
  }
}
