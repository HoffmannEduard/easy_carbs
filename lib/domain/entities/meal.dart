import 'package:uuid/uuid.dart';

// Seperation of Concerns! Deshalb die UUID und weitere Default-Logik hier und nicht in der DB-Schicht!

class Meal {
  final String id;
  final String name;
  final double carbs;
  final DateTime timestamp;

  final double? fat;
  final double? protein;
  final String? location;
  final double? quantity;
  final String? note;
  final String? categories;
  final String imagePath;

  Meal({
    String? id,
    required this.name,
    required this.carbs,
    DateTime? timestamp,
    this.fat,
    this.protein,
    this.location,
    this.quantity,
    this.note,
    this.categories,
    String? imagePath,
  })  : id = id ?? const Uuid().v4(), // UUID erzeugen, wenn nicht gesetzt
        timestamp = timestamp ?? DateTime.now(),
        imagePath = imagePath ?? 'assets/defaults/default-burger.jpg';
}

