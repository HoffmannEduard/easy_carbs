import 'package:easy_carbs/domain/entities/carb_unit.dart';

/// Berechnet BE / KE und FPE anhand der Nährwerte für die App
class NutritionCalculator {
  const NutritionCalculator();

 /// Rechnet Kohlenhydrate in Gramm in die gewünschte Einheit um.
 /// Erwartet carbsGramm, gibt berechneten Einheiten (BE / KE) zurück.
  double calculateCarbsInUnit({
    required double carbsGramm,
    required CarbUnit unit,
  }) {
    final gramsPerUnit = unit == CarbUnit.be ? 12.0 : 10.0;
    return carbsGramm / gramsPerUnit;
  }

/// Berechnet FPE (Fett-Protein-Einheiten) aus Fett und Protein in Gramm.
/// Erwartet fatGramm und proteinGramm, gibt die berechnete FPE zurück
  double calculateFpe({
    required double fatGramm,
    required double proteinGramm,
  }) {
    final kcal = fatGramm * 9.0 + proteinGramm * 4.0;
    return kcal / 100.0;
  }
}