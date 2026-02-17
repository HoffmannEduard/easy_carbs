import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';

/// Jeder Block repräsentiert einen definierten Zeitbereich
/// (morning, midday, evening, night) mit eigenem Insulinfaktor.
class FixedInsulinFactors {
  final TimeBasedInsulinFactor morning;
  final TimeBasedInsulinFactor midday;
  final TimeBasedInsulinFactor evening;
  final TimeBasedInsulinFactor night;

  const FixedInsulinFactors({
    required this.morning,
    required this.midday,
    required this.evening,
    required this.night,
  });

  /// Gibt alle Blöcke in fester Reihenfolge als Liste zurück.
  List<TimeBasedInsulinFactor> asList() => [morning, midday, evening, night];

  /// Liefert den Block passend zur angegebenen [InsulinBlockId].
  TimeBasedInsulinFactor byId(InsulinBlockId id) => switch (id) {
        InsulinBlockId.morning => morning,
        InsulinBlockId.midday => midday,
        InsulinBlockId.evening => evening,
        InsulinBlockId.night => night,
      };

  FixedInsulinFactors copyWith({
    TimeBasedInsulinFactor? morning,
    TimeBasedInsulinFactor? midday,
    TimeBasedInsulinFactor? evening,
    TimeBasedInsulinFactor? night,
  }) {
    return FixedInsulinFactors(
      morning: morning ?? this.morning,
      midday: midday ?? this.midday,
      evening: evening ?? this.evening,
      night: night ?? this.night,
    );
  }
}
