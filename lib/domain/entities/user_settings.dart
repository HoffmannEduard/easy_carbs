import 'package:easy_carbs/domain/entities/carb_unit.dart';

class UserSettings {
  final String id;
  final CarbUnit carbUnit;
  final double? carbFactor;
  final bool showFpe;
  final double? fpeFactor;

  UserSettings({
    required this.id,
    required this.carbUnit,
    this.carbFactor,
    required this.showFpe,
    this.fpeFactor,
  });

  UserSettings copyWith({
    String? id,
    CarbUnit? carbUnit,
    double? carbFactor,
    bool? showFpe,
    double? fpeFactor,
  }) {
    return UserSettings(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      carbFactor: carbFactor ?? this.carbFactor,
      showFpe: showFpe ?? this.showFpe,
      fpeFactor: fpeFactor ?? this.fpeFactor,
    );
  }
}
