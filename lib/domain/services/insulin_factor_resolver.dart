import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';

/// Ermittelt den aktiven Insulinfaktor für eine gegebene Uhrzeit.
/// Die Zuordnung basiert auf vier Zeitblöcken (morning, midday, evening, night).
class InsulinFactorResolver {
  const InsulinFactorResolver();

  /// Gibt den passenden Insulinfaktor für now zurück.
  double factorForTime(FixedInsulinFactors factors, TimeOfDay now) {
    final normalized = FixedInsulinSchedule.normalize(factors);

    final nowMin = FixedInsulinSchedule.toMin(now);

    // Startgrenzen (0..1439, night ggf. hoch)
    final m = FixedInsulinSchedule.toMin(normalized.morning.startTime);
    final d = FixedInsulinSchedule.toMin(normalized.midday.startTime);
    final e = FixedInsulinSchedule.toMin(normalized.evening.startTime);
    final n = FixedInsulinSchedule.toMin(normalized.night.startTime);

    // Bereiche: [m,d), [d,e), [e,n), [n,1440) U [0,m)
    if (nowMin >= m && nowMin < d) return normalized.morning.insulinFactor;
    if (nowMin >= d && nowMin < e) return normalized.midday.insulinFactor;
    if (nowMin >= e && nowMin < n) return normalized.evening.insulinFactor;

    // Nacht: >= n ODER < m
    return normalized.night.insulinFactor;
  }
}
