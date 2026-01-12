import 'package:easy_carbs/app/core/app_assets.dart';
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
        imagePath = imagePath ?? AppAssets.defaultMealImagePath;

  Meal copyWith({
    String? id,
    String? name,
    DateTime? timestamp,
    CarbUnit? carbUnit,
    double? carbsInUnit,
    double? fpe,
    String? location,
    Nutrition? nutrition,
    double? portionsize,
    PortionUnit? portionUnit,
    String? note,
    String? categories,
    String? imagePath,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      carbUnit: carbUnit ?? this.carbUnit,
      carbsInUnit: carbsInUnit ?? this.carbsInUnit,
      fpe: fpe ?? this.fpe,
      location: location ?? this.location,
      nutrition: nutrition ?? this.nutrition,
      portionsize: portionsize ?? this.portionsize,
      portionUnit: portionUnit ?? this.portionUnit,
      note: note ?? this.note,
      categories: categories ?? this.categories,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

