import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'carb_unit.dart';

/// Domänen-Entity für globale Benutzereinstellungen.
class UserSettings {
  final String id;
  final CarbUnit carbUnit;
  final FixedInsulinFactors insulinFactors;
  final bool showInsulin;
  final double? fpeFactor;

  UserSettings({
    /// Eindeutige ID der Einstellungen.
    /// Standardmäßig wird eine feste ID (`'user'`) verwendet,
    /// da in der App nur ein Einstellungsdatensatz existiert.
    String? id,
    /// Globale Kohlenhydrat-Einheit (BE oder KE).
    required this.carbUnit,
    /// Zeitabhängige Insulinfaktoren (morning, midday, evening, night).
    required this.insulinFactors,
    /// Gibt an, ob Insulineinheiten in der App berechnet/angezeigt werden.
    required this.showInsulin,
    /// Faktor zur Berechnung der Insulineinheiten für FPE.
    this.fpeFactor,
  }) : id = id ?? 'user';

  UserSettings copyWith({
    String? id,
    CarbUnit? carbUnit,
    FixedInsulinFactors? insulinFactors,
    bool? showInsulin,
    double? fpeFactor,
  }) {
    return UserSettings(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      insulinFactors: insulinFactors ?? this.insulinFactors,
      showInsulin: showInsulin ?? this.showInsulin,
      fpeFactor: fpeFactor ?? this.fpeFactor,
    );
  }
}
