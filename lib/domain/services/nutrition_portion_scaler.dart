import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';

class NutritionPortionScaler {
  const NutritionPortionScaler();

  Nutrition scale({
    required Nutrition nutrition,
    required PortionUnit unit,
    required double portionSize,
  }) {

    if (portionSize < 0) {
      throw StateError('Portionsgröße muss >= 0 sein');
    }

    switch (unit) {
      case PortionUnit.portion:
        return _multiplicate(nutrition, portionSize);

      case PortionUnit.gramm:
        return _multiplicate(nutrition, portionSize / 100.0);

      case PortionUnit.piece:
        if (nutrition.weightOnePiece == null) {
          throw StateError('Gramm pro Stück notwendig!');
        }
        final totalGrams = portionSize * nutrition.weightOnePiece!;
        return _multiplicate(nutrition, totalGrams / 100.0);
    }
  }

  Nutrition _multiplicate(Nutrition n, double factor) => n.copyWith(
    carbs: n.carbs == null ? null : n.carbs! * factor,
    fat: n.fat == null ? null : n.fat! * factor,
    protein: n.protein == null ? null : n.protein! * factor,
  );
}
