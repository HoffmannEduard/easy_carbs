import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:uuid/uuid.dart';

class UserSettings {
  final String id;
  final CarbUnit carbUnit;
  final double carbFactor;
  final bool showFpe;
  final double? fpeFactor;
  final bool darkMode;

  UserSettings({
    String? id,
    required this.carbUnit,
    required this.carbFactor,
    bool? showFpe,
    this.fpeFactor,
    bool? darkMode,
  })  : id = id ?? const Uuid().v4(),
        showFpe = showFpe ?? true,
        darkMode = darkMode ?? false;

  UserSettings copyWith({
    String? id,
    CarbUnit? carbUnit,
    double? carbFactor,
    bool? showFpe,
    double? fpeFactor,
    bool? darkMode,
  }) {
    return UserSettings(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      carbFactor: carbFactor ?? this.carbFactor,
      showFpe: showFpe ?? this.showFpe,
      fpeFactor: fpeFactor ?? this.fpeFactor,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
