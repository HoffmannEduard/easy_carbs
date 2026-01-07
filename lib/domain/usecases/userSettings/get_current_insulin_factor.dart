import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';

/// Gibt den aktuellen insulinbasierten Faktor für die gegebene Uhrzeit zurück.
/// Logik für Nachtüberschneidung liegt hier, nicht in der Entity.
class GetCurrentInsulinFactor {
  final UserSettings settings;

  GetCurrentInsulinFactor(this.settings);

  TimeBasedInsulinFactor call(TimeOfDay time) {
    return settings.insulinFactors.firstWhere(
      (factor) => _appliesTo(factor, time),
      orElse: () => throw StateError('Kein Faktor für diese Uhrzeit definiert'),
    );
  }

  bool _appliesTo(TimeBasedInsulinFactor factor, TimeOfDay time) {
    final current = time.hour * 60 + time.minute;
    final start = factor.startTime.hour * 60 + factor.startTime.minute;
    final end = factor.endTime.hour * 60 + factor.endTime.minute;

    if (start < end) {
      return current >= start && current < end;
    } else {
      // Nachtübergreifendes Intervall
      return current >= start || current < end;
    }
  }
}
