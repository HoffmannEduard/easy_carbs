import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TimeBasedInsulinFactor {
  final String id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final double insulinFactor;

  TimeBasedInsulinFactor({
    String? id,
    required this.startTime,
    required this.endTime,
    required this.insulinFactor,
  }) : id = id ?? const Uuid().v4();

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
