import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/services/insulin_factor_resolver.dart';

/// Use Case zur Berechnung der Insulineinheiten für Kohlenhydrate.
///
/// Die Berechnung basiert auf:
/// - berechneten BE/KE [carbsInUnit]
/// - zeitabhängigem Insulinfaktor aus den [UserSettings]
/// - und erfolgt nur, wenn die Insulinanzeige aktiviert ist ('settings.showInsulin')
class CalculateCarbsInsulinUnitsUseCase {
  final InsulinFactorResolver _resolver;

  const CalculateCarbsInsulinUnitsUseCase(this._resolver);

  /// Berechnet die zu spritzenden Insulineinheiten.
  /// - Ermittelt den aktiven Insulinfaktor für [now].
  /// - Multipliziert diesen mit [carbsInUnit].
  /// - Rundet das Ergebnis auf 0.1 IE.
  double? call({
    required UserSettings settings,
    required double? carbsInUnit, // nullable
    required TimeOfDay now,
  }) {
    if (carbsInUnit == null) return null;

    final factor = _resolver.factorForTime(settings.insulinFactors, now);
    return _roundTo(carbsInUnit * factor, 0.1);
  }

  /// Rundet einen Wert auf das angegebene Schrittmaß (z. B. 0.1 IE).
  double _roundTo(double value, double step) =>
      (value / step).roundToDouble() * step;
}
