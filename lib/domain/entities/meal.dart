import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:uuid/uuid.dart';

// Seperation of Concerns! Deshalb die UUID und weitere Default-Logik hier und nicht in der DB-Schicht!

class Meal {
  final String id;
  final String name;
  final DateTime timestamp;
  final CarbUnit carbUnit;

  final double? carbsInUnit;
  final double? fpe;
  final String? location;
  final Nutrition? nutrition;
  final double? portionsize;
  final PortionUnit? portionUnit;
  final String? note;
  final String? categories;
  final String imagePath;

  Meal({
    String? id,
    required this.name,
    required this.carbUnit,
    DateTime? timestamp,
    this.carbsInUnit,
    this.fpe,
    this.location,
    this.nutrition,
    this.portionsize,
    this.portionUnit,
    this.note,
    this.categories,
    String? imagePath,
  })  : id = id ?? const Uuid().v4(), // UUID erzeugen, wenn nicht gesetzt
        timestamp = timestamp ?? DateTime.now(),
        imagePath = imagePath ?? 'assets/defaults/default-burger.jpg';
}

