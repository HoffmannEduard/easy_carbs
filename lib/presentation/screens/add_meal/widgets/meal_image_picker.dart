import 'dart:io';
import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MealImagePicker extends StatelessWidget {
  final XFile? image;
  final void Function(ImageSource source) onPickImage;

  const MealImagePicker({
    super.key,
    required this.image,
    required this.onPickImage,
  });

  void _showSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Galerie'),
                onTap: () {
                  Navigator.pop(context);
                  onPickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  onPickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showSourceSelector(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: image != null
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppAssets.defaultMealImagePath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
