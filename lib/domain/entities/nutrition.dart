import 'package:uuid/uuid.dart';

class Nutrition {
  final String id;
  final double? carbs;
  final double? sugar;
  final double? fat;
  final double? protein;

Nutrition({
  String? id,
  this.carbs,
  this.sugar,
  this.fat,
  this.protein
})   : id = id ?? const Uuid().v4(); // UUID erzeugen, wenn nicht gesetzt

// copyWith-Methode
  Nutrition copyWith({
    double? carbs,
    double? sugar,
    double? fat,
    double? protein,
  }) {
    return Nutrition(
      id: id, // ID bleibt gleich
      carbs: carbs ?? this.carbs,
      sugar: sugar ?? this.sugar,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
    );
  }

}