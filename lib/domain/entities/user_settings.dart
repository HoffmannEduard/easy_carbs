import 'time_based_insulin_factor.dart';
import 'carb_unit.dart';

class UserSettings {
  final String id;
  final CarbUnit carbUnit;
  final List<TimeBasedInsulinFactor> insulinFactors;
  final bool showFpe;
  final double? fpeFactor;

  UserSettings({
    String? id,
    required this.carbUnit,
    required this.insulinFactors,
    required this.showFpe,
    this.fpeFactor,
  }) : id = id ?? 'user';

  UserSettings copyWith({
    String? id,
    CarbUnit? carbUnit,
    List<TimeBasedInsulinFactor>? insulinFactors,
    bool? showFpe,
    double? fpeFactor,
  }) {
    return UserSettings(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      insulinFactors: insulinFactors ?? this.insulinFactors,
      showFpe: showFpe ?? this.showFpe,
      fpeFactor: fpeFactor ?? this.fpeFactor,
    );
  }
}
