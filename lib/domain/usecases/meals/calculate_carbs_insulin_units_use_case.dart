import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/services/insulin_factor_resolver.dart';

class CalculateCarbsInsulinUnitsUseCase {
  final InsulinFactorResolver _resolver;

  const CalculateCarbsInsulinUnitsUseCase(this._resolver);

  double? call({
    required UserSettings settings,
    required double? carbsInUnit, // nullable
    required TimeOfDay now,
  }) {
    if (carbsInUnit == null) return null;

    final factor = _resolver.factorForTime(settings.insulinFactors, now);
    return _roundTo(carbsInUnit * factor, 0.1);
  }

  double _roundTo(double value, double step) =>
      (value / step).roundToDouble() * step;
}
