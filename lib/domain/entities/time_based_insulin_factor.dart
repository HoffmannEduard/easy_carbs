import 'package:flutter/material.dart';

class TimeBasedInsulinFactor {
  final String id; // 'morning'|'midday'|'evening'|'night'
  final TimeOfDay startTime; // Grenze
  final TimeOfDay endTime;   // Start des nächsten Blocks (night wrap)
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
