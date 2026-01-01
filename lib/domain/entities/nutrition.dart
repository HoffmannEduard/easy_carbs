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


}