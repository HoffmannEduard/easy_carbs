import 'package:easy_carbs/domain/entities/user_settings.dart';

/// Use Case zur Berechnung der Insulineinheiten für FPE.
/// /// Die Berechnung erfolgt nur, wenn:
/// - die Insulinanzeige aktiviert ist (`settings.showInsulin`)
/// - ein FPE-Faktor definiert ist
/// - ein FPE-Wert vorliegt
class CalculateFpeInsulinUnitsUseCase {
  const CalculateFpeInsulinUnitsUseCase();

 /// Berechnet die Insulineinheiten für Fett-Protein-Einheiten.
 /// Das Ergebnis wird auf 0.1 IE gerundet.
  double? call({
    required UserSettings settings,
    required double? fpe, // nullable
  }) {
    if (!settings.showInsulin) return null;

    final factor = settings.fpeFactor;
    if (factor == null) return null;
    if (fpe == null) return null;

    return _roundTo(fpe * factor, 0.1);
  }

  /// Rundet einen Wert auf das angegebene Schrittmaß (z. B. 0.1 IE).
  double _roundTo(double value, double step) =>
      (value / step).roundToDouble() * step;
}
