import 'package:easy_carbs/app/core/app_assets.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:uuid/uuid.dart';

/// Domänen-Entity für eine gespeicherte Mahlzeit.
class Meal {
  /// Eindeutige ID (UUID)
  final String id;
  /// Anzeigename der Mahlzeit.
  final String name;
  /// Zeitpunkt der Erstellung/Speicherung.
  final DateTime timestamp;
  /// Gewählte Kohlenhydrat-Einheit (BE oder KE).
  final CarbUnit carbUnit;
  /// Aktiviert die automatische Berechnung von BE/KE und FPE.
  final bool autocalculate;
  /// Berechnete oder manuell gesetzte Kohlenhydrate in gewählter Einheit.
  final double? carbsInUnit;
  /// Berechnete oder manuell gesetzte Fett-Protein-Einheiten.
  final double? fpe;
  /// Optionaler Ort/Marke/Restaurant der Mahlzeit.
  final String? location;
  /// Optionale Nährwertangaben (Basis für Autocalc).
  final Nutrition? nutrition;
  /// Portionsgröße (abhängig von [portionUnit]).
  final double? portionsize;
  /// Einheit der Portionsgröße (z. B. Gramm, Portion, Stück).
  final PortionUnit? portionUnit;
  /// Freitext-Notiz.
  final String? note;
  /// Kategorien/Tags (noch keine Funktionalität implementiert).
  final String? categories;
  /// Pfad zum gespeicherten Bild.
  final String imagePath;

  Meal({
    String? id,
    required this.name,
    required this.carbUnit,
    DateTime? timestamp,
    this.autocalculate = false,
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
    bool? autocalculate,
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
      autocalculate: autocalculate ?? this.autocalculate,
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

