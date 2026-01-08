import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSettingsAsyncNotifier extends AsyncNotifier<UserSettings> {
  late final _repo = ref.read(userSettingsRepositoryProvider);

  @override
  Future<UserSettings> build() async {
    // Stream abonnieren oder Settings laden
    final settings = await _repo.getSettings();
    if (settings != null) return settings;

    // Default Settings ohne InsulinFactors
    final defaultSettings = UserSettings(
      id: 'user', // einzige Instanz
      carbUnit: CarbUnit.be,
      insulinFactors: [],
      showFpe: true,
      fpeFactor: null,
    );

    await _repo.saveSettings(defaultSettings);
    return defaultSettings;
  }

  /// Toggle ShowFpe
  Future<void> toggleShowFpe(bool value) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(showFpe: value);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }

  /// Setze CarbUnit
  Future<void> setCarbUnit(CarbUnit unit) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(carbUnit: unit);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }

  /// Setze FPE-Faktor
  Future<void> setFpeFactor(double? fpeFactor) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(fpeFactor: fpeFactor);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }

  /// InsulinFactors ersetzen (z. B. beim Bearbeiten der Liste)
  Future<void> setInsulinFactors(List<TimeBasedInsulinFactor> factors) async {
    final current = state.value;
    if (current == null) return;

    final updated = current.copyWith(insulinFactors: factors);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }

  /// Einen einzelnen InsulinFactor hinzufügen oder aktualisieren
  Future<void> addOrUpdateInsulinFactor(TimeBasedInsulinFactor factor) async {
    final current = state.value;
    if (current == null) return;

    // Existierende Faktoren ersetzen, falls ID schon vorhanden
    final updatedFactors = List<TimeBasedInsulinFactor>.from(current.insulinFactors);
    final index = updatedFactors.indexWhere((f) => f.id == factor.id);
    if (index >= 0) {
      updatedFactors[index] = factor;
    } else {
      updatedFactors.add(factor);
    }

    final updated = current.copyWith(insulinFactors: updatedFactors);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }

  /// Einen InsulinFactor löschen
  Future<void> deleteInsulinFactor(String factorId) async {
    final current = state.value;
    if (current == null) return;

    final updatedFactors =
        current.insulinFactors.where((f) => f.id != factorId).toList();

    final updated = current.copyWith(insulinFactors: updatedFactors);
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }
}

// ================= Provider =================

final userSettingsNotifierProvider =
    AsyncNotifierProvider<UserSettingsAsyncNotifier, UserSettings>(
        () => UserSettingsAsyncNotifier());
