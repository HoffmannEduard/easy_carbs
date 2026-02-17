import 'package:uuid/uuid.dart';

/// Domänen-Entity für Nährwertangaben einer Mahlzeit.
class Nutrition {
  /// Eindeutige ID (UUID).
  final String id;
  /// Kohlenhydrate in Gramm (relevant für Autocalc!).
  final double? carbs;
  /// Zucker in Gramm.
  final double? sugar;
  /// Fett in Gramm (relevant für Autocalc!).
  final double? fat;
  /// gesättigte Fettsäuren in Gramm.
  final double? saturatedFat;
  /// Eiweiß in Gramm (relevant für Autocalc!).
  final double? protein;
  /// Gewicht eines Stücks in Gramm (relevant bei PortionUnit.piece).
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