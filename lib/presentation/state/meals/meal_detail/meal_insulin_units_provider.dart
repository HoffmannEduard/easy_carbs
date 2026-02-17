import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:easy_carbs/presentation/state/insulin/insulin_usecases_provider.dart';

/// Aggregiertes Ergebnis der Insulinberechnung für eine Mahlzeit.
/// Enthält:
/// - Insulineinheiten für BE/KE
/// - Insulineinheiten für FPE
/// - die zugrunde liegende Uhrzeit
class MealInsulinUnits {
  final double? carbsUnits; // IE für BE/KE
  final double? fpeUnits;   // IE für FPE
  final TimeOfDay now;

  MealInsulinUnits({
    required this.carbsUnits,
    required this.fpeUnits,
    required this.now,
  });
}

/// Provider zur Berechnung der Insulineinheiten für eine konkrete Mahlzeit, anhand
/// - der ausgewählten Mahlzeit
/// - der aktuellen Benutzereinstellungen
/// - der aktuellen Uhrzeit
/// Gibt ein [AsyncValue] zurück, um Lade- und Fehlerzustände korrekt abzubilden.
final mealInsulinUnitsProvider =
    Provider.family<AsyncValue<MealInsulinUnits>, String>((ref, mealId) {
  final mealAsync = ref.watch(mealByIdProvider(mealId));
  final settingsAsync = ref.watch(userSettingsNotifierProvider);
  final nowAsync = ref.watch(currentTimeProvider); // StreamProvider -> AsyncValue<TimeOfDay>

  if (mealAsync.isLoading || settingsAsync.isLoading || nowAsync.isLoading) {
    return const AsyncValue.loading();
  }

  final mealErr = mealAsync.asError;
  if (mealErr != null) return AsyncValue.error(mealErr.error, mealErr.stackTrace);

  final settingsErr = settingsAsync.asError;
  if (settingsErr != null) return AsyncValue.error(settingsErr.error, settingsErr.stackTrace);

  final nowErr = nowAsync.asError;
  if (nowErr != null) return AsyncValue.error(nowErr.error, nowErr.stackTrace);

  final meal = mealAsync.value!;
  final settings = settingsAsync.value!;
  final now = nowAsync.value!;

  final carbsCalc = ref.read(calculateCarbsInsulinUnitsProvider);
  final fpeCalc = ref.read(calculateFpeInsulinUnitsProvider);

  final carbsUnits = carbsCalc(
    settings: settings,
    carbsInUnit: meal.carbsInUnit, // nullable
    now: now,
  );

  final fpeUnits = fpeCalc(
    settings: settings,
    fpe: meal.fpe, // nullable
  );

  return AsyncValue.data(
    MealInsulinUnits(
      carbsUnits: carbsUnits,
      fpeUnits: fpeUnits,
      now: now,
    ),
  );
});
