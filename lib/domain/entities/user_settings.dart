import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'carb_unit.dart';

class UserSettings {
  final String id;
  final CarbUnit carbUnit;
  final FixedInsulinFactors insulinFactors;
  final bool showInsulin;
  final double? fpeFactor;

  UserSettings({
    String? id,
    required this.carbUnit,
    required this.insulinFactors,
    required this.showInsulin,
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
