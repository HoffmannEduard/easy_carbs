import 'package:easy_carbs/domain/entities/user_settings.dart';

class CalculateFpeInsulinUnitsUseCase {
  const CalculateFpeInsulinUnitsUseCase();

  double? call({
    required UserSettings settings,
    required double? fpe, // nullable
  }) {
    if (!settings.showFpe) return null;

    final factor = settings.fpeFactor;
    if (factor == null) return null;
    if (fpe == null) return null;

    return _roundTo(fpe * factor, 0.1);
  }

  double _roundTo(double value, double step) =>
      (value / step).roundToDouble() * step;
}
