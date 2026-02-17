import 'dart:async';

import 'package:easy_carbs/domain/usecases/meals/calculate_carbs_insulin_units_use_case.dart';
import 'package:easy_carbs/domain/usecases/meals/calculate_fpe_insulin_units_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/domain/services/insulin_factor_resolver.dart';

/// Provider für die Auflösung des zeitabhängigen Insulinfaktors.
final insulinFactorResolverProvider =
    Provider<InsulinFactorResolver>((ref) => const InsulinFactorResolver());

/// Provider für den Use Case zur Berechnung der Insulineinheiten für BE/KE.
final calculateCarbsInsulinUnitsProvider =
    Provider((ref) => CalculateCarbsInsulinUnitsUseCase(ref.read(insulinFactorResolverProvider)));

/// Provider für den Use Case zur Berechnung der Insulineinheiten für FPE.
final calculateFpeInsulinUnitsProvider =
    Provider((ref) => const CalculateFpeInsulinUnitsUseCase());


/// Streamt die aktuelle Uhrzeit (Stunden/Minuten) und aktualisiert sich jede Minute.
/// Wird auto-disposed, da die Uhrzeit nur bei aktiver UI benötigt wird.
final currentTimeProvider = StreamProvider.autoDispose<TimeOfDay>((ref) {
  final controller = StreamController<TimeOfDay>();

  void emitNow() {
    final now = DateTime.now();
    controller.add(TimeOfDay(hour: now.hour, minute: now.minute));
  }

  emitNow();

  final timer = Timer.periodic(const Duration(minutes: 1), (_) => emitNow());

  ref.onDispose(() {
    timer.cancel();
    controller.close();
  });

  return controller.stream;
});
