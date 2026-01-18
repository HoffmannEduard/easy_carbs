import 'package:uuid/uuid.dart';

class Nutrition {
  final String id;
  final double? carbs;
  final double? sugar;
  final double? fat;
  final double? saturatedFat;
  final double? protein;
  final double? weightOnePiece;

Nutrition({
  String? id,
  this.carbs,
  this.sugar,
  this.fat,
  this.saturatedFat,
  this.protein,
  this.weightOnePiece,
})   : id = id ?? const Uuid().v4(); // UUID erzeugen, wenn nicht gesetzt

// copyWith-Methode
  Nutrition copyWith({
    double? carbs,
    double? sugar,
    double? fat,
    double? saturatedFat,
    double? protein,
    double? weightOnePiece
  }) {
    return Nutrition(
      id: id, // ID bleibt gleich
      carbs: carbs ?? this.carbs,
      sugar: sugar ?? this.sugar,
      fat: fat ?? this.fat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      protein: protein ?? this.protein,
      weightOnePiece: weightOnePiece ?? this.weightOnePiece
    );
  }

}