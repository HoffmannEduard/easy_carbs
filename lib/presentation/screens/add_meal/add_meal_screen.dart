import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/state/meals/meal_list_notifier.dart';
import 'package:easy_carbs/presentation/screens/add_meal/meal_image_picker.dart';

class AddMealScreen extends ConsumerStatefulWidget {
  const AddMealScreen({super.key});

  @override
  ConsumerState<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends ConsumerState<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // --- Bild auswählen (UI-only) ---
  Future<void> _pickImage(ImageSource imageSource) async {
    final picked = await _picker.pickImage(
      source: imageSource,
      imageQuality: 85,
    );

    if (picked != null) {
      setState(() {
        _selectedImage = picked;
      });
    }
  }


  Future<void> _createMeal() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final mealId = await ref
          .read(mealListNotifierProvider.notifier)
          .createMeal(
            name: _nameController.text.trim(),
            location: _locationController.text.trim().isEmpty
                ? null
                : _locationController.text.trim(),
            imageFile: _selectedImage,
          );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MealDetailScreen(mealId: mealId),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mahlzeit konnte nicht gespeichert werden'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Mahlzeit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Bild ---
                MealImagePicker(
                  image: _selectedImage,
                  onPickImage: _pickImage,
                ),

                const SizedBox(height: 24),

                // --- Name ---
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name ist erforderlich';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // --- Location ---
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Ort',
                  ),
                ),

                const SizedBox(height: 32),

                // --- Erstellen Button ---
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _createMeal,
                    child: const Text('Erstellen'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
