import 'package:flutter/material.dart';

/// Repräsentiert einen zeitabhängigen Insulinfaktor innerhalb eines Tages.
class TimeBasedInsulinFactor {
  /// Ein Block ist durch eine Startzeit und eine Endzeit definiert.
  /// Die Endzeit entspricht intern der Startzeit des nächsten Blocks
  final String id; 
  final TimeOfDay startTime;
  final TimeOfDay endTime;  
  final double insulinFactor;

  TimeBasedInsulinFactor({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.insulinFactor,
  });

  TimeBasedInsulinFactor copyWith({
    String? id,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    double? insulinFactor,
  }) {
    return TimeBasedInsulinFactor(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      insulinFactor: insulinFactor ?? this.insulinFactor,
    );
  }
}
