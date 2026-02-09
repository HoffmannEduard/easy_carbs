import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';

/// Hilfsfunktionen für einen festen Tagesplan aus 4 Insulin-Blöcken.
///
/// Der Plan besteht aus den Blöcken morning, midday, evening, night.
/// Intern wird über Startzeiten gearbeitet; die Endzeit eines Blocks ist
/// immer die Startzeit des nächsten Blocks (night -> morning, zyklisch).
///
/// Zusätzlich werden einfache Validierungsregeln erzwungen (z. B. Mindestabstand).
class FixedInsulinSchedule {
  /// Minuten pro Tag (0..1439).
  static const int minutesPerDay = 1440;
  /// Mindestabstand zwischen zwei Block-Startzeiten
  static const int minGap = 5; // UX/Validierung

  /// Wandelt eine Startzeit des nächsten Blocks in eine "Ende inklusiv"-Anzeige um.
  static TimeOfDay displayEndInclusive(TimeOfDay nextBlockStart) {
  final endMin = toMin(nextBlockStart);
  final last = (endMin - 1) < 0 ? 1439 : (endMin - 1);
  return fromMin(last);
}

  /// Konvertiert [TimeOfDay] in Minuten seit Mitternacht (0..1439).
  static int toMin(TimeOfDay t) => t.hour * 60 + t.minute;
  /// Konvertiert Minuten seit Mitternacht in [TimeOfDay].
  static TimeOfDay fromMin(int m) => TimeOfDay(hour: (m ~/ 60) % 24, minute: m % 60);

  /// Liefert einen initialen 4-Block-Plan mit Standardzeiten und Faktor 1.0.
  ///
  /// Die Rückgabe wird über [normalize] konsistent gemacht (Endzeiten abgeleitet).
  static FixedInsulinFactors defaults() {
    // EndTime wird gleich abgeleitet
    final morning = TimeBasedInsulinFactor(
      id: InsulinBlockId.morning.key,
      startTime: const TimeOfDay(hour: 6, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      insulinFactor: 1.0,
    );
    final midday = TimeBasedInsulinFactor(
      id: InsulinBlockId.midday.key,
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      insulinFactor: 1.0,
    );
    final evening = TimeBasedInsulinFactor(
      id: InsulinBlockId.evening.key,
      startTime: const TimeOfDay(hour: 18, minute: 0),
      endTime: const TimeOfDay(hour: 22, minute: 0),
      insulinFactor: 1.0,
    );
    final night = TimeBasedInsulinFactor(
      id: InsulinBlockId.night.key,
      startTime: const TimeOfDay(hour: 22, minute: 0),
      endTime: const TimeOfDay(hour: 6, minute: 0), // wrap
      insulinFactor: 1.0,
    );

    return normalize(FixedInsulinFactors(
      morning: morning,
      midday: midday,
      evening: evening,
      night: night,
    ));
  }

  /// Normalisiert einen Plan und erzwingt grundlegende Konsistenzregeln.
  /// - Reihenfolge morning < midday < evening < night (in Minuten, 0..1439)
  /// - minGap zwischen den Startzeiten
  /// - endTimes werden strikt als "Start des nächsten Blocks" abgeleitet (night -> morning)
  static FixedInsulinFactors normalize(FixedInsulinFactors factors) {
    final m = toMin(factors.morning.startTime).clamp(0, minutesPerDay - 1);
    var d = toMin(factors.midday.startTime).clamp(0, minutesPerDay - 1);
    var e = toMin(factors.evening.startTime).clamp(0, minutesPerDay - 1);
    var n = toMin(factors.night.startTime).clamp(0, minutesPerDay - 1);

    d = max(d, m + minGap);
    e = max(e, d + minGap);
    n = max(n, e + minGap);

    d = min(d, minutesPerDay - 1);
    e = min(e, minutesPerDay - 1);
    n = min(n, minutesPerDay - 1);

    // ensure night duration >= minGap: (1440 - n) + m
    final nightDuration = (minutesPerDay - n) + m;
    if (nightDuration < minGap) {
      final needed = minGap - nightDuration;
      final newM = min(m + needed, d - minGap);
      return _rebuild(
        factors,
        morningStart: newM,
        middayStart: d,
        eveningStart: e,
        nightStart: n,
      );
    }

    return _rebuild(
      factors,
      morningStart: m,
      middayStart: d,
      eveningStart: e,
      nightStart: n,
    );
  }

  /// Baut einen konsistenten Plan aus Startzeiten (Minuten) neu auf.
  /// Endzeiten werden automatisch aus der jeweils nächsten Startzeit gesetzt.
  static FixedInsulinFactors _rebuild(
    FixedInsulinFactors factors, {
    required int morningStart,
    required int middayStart,
    required int eveningStart,
    required int nightStart,
  }) {
    final morning = factors.morning.copyWith(
      startTime: fromMin(morningStart),
      endTime: fromMin(middayStart),
    );
    final midday = factors.midday.copyWith(
      startTime: fromMin(middayStart),
      endTime: fromMin(eveningStart),
    );
    final evening = factors.evening.copyWith(
      startTime: fromMin(eveningStart),
      endTime: fromMin(nightStart),
    );
    final night = factors.night.copyWith(
      startTime: fromMin(nightStart),
      endTime: fromMin(morningStart), // wrap
    );

    return FixedInsulinFactors(
      morning: morning,
      midday: midday,
      evening: evening,
      night: night,
    );
  }

  /// Setzt die Startzeit eines Blocks und normalisiert anschließend den Plan.
  static FixedInsulinFactors setStart(FixedInsulinFactors factors, InsulinBlockId id, TimeOfDay newStart) {
    final updated = switch (id) {
      InsulinBlockId.morning => factors.copyWith(morning: factors.morning.copyWith(startTime: newStart)),
      InsulinBlockId.midday => factors.copyWith(midday: factors.midday.copyWith(startTime: newStart)),
      InsulinBlockId.evening => factors.copyWith(evening: factors.evening.copyWith(startTime: newStart)),
      InsulinBlockId.night => factors.copyWith(night: factors.night.copyWith(startTime: newStart)),
    };
    return normalize(updated);
  }

  /// Endzeit eines Blocks ändern = Startzeit des nächsten Blocks setzen (zyklisch).
  /// UI liefert i. d. R. "Ende inklusiv"; arbeitet intern über Startgrenzen.
  static FixedInsulinFactors setEnd(FixedInsulinFactors factors, InsulinBlockId id, TimeOfDay newEnd) {
    final next = switch (id) {
      InsulinBlockId.morning => InsulinBlockId.midday,
      InsulinBlockId.midday => InsulinBlockId.evening,
      InsulinBlockId.evening => InsulinBlockId.night,
      InsulinBlockId.night => InsulinBlockId.morning, // wrap
    };
    return setStart(factors, next, newEnd);
  }

  /// Setzt den Insulinfaktor eines Blocks und normalisiert anschließend den Plan.
  static FixedInsulinFactors setFactor(FixedInsulinFactors factors, InsulinBlockId id, double factor) {
    final updated = switch (id) {
      InsulinBlockId.morning => factors.copyWith(morning: factors.morning.copyWith(insulinFactor: factor)),
      InsulinBlockId.midday => factors.copyWith(midday: factors.midday.copyWith(insulinFactor: factor)),
      InsulinBlockId.evening => factors.copyWith(evening: factors.evening.copyWith(insulinFactor: factor)),
      InsulinBlockId.night => factors.copyWith(night: factors.night.copyWith(insulinFactor: factor)),
    };
    return normalize(updated);
  }

  /// Formatiert eine Uhrzeit im deutschen Format `HH:mm`.
  static String formatGerman(TimeOfDay time) {
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

}
