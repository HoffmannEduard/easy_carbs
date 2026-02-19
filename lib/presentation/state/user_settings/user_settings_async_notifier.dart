import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AsyncNotifier zur Verwaltung der Benutzereinstellungen.
/// Verantwortlich für:
/// - Initiales Laden oder Anlegen von Default-Settings
/// - Aktualisierung einzelner Felder
/// - Persistenz über das Repository
class UserSettingsAsyncNotifier extends AsyncNotifier<UserSettings> {
  late final _repo = ref.read(userSettingsRepositoryProvider);

  /// Lädt vorhandene Einstellungen oder erstellt Default-Werte.
  @override
  Future<UserSettings> build() async {
    final settings = await _repo.getSettings();
    if (settings != null) return _ensureNormalized(settings);

    final defaultSettings = UserSettings(
      id: 'user',
      carbUnit: CarbUnit.be,
      insulinFactors: FixedInsulinSchedule.defaults(),
      showInsulin: true,
      fpeFactor: null,
    );

    await _repo.saveSettings(defaultSettings);
    return defaultSettings;
  }

  /// Stellt sicher, dass die Insulinfaktoren normalisiert sind.
  UserSettings _ensureNormalized(UserSettings s) {
    final normalized = FixedInsulinSchedule.normalize(s.insulinFactors);
    return s.copyWith(insulinFactors: normalized);
  }

  /// Aktiviert oder deaktiviert die Anzeige/Berechnung von Insulin.
  Future<void> toggleShowInsulin(bool value) async => _update((s) => s.copyWith(showInsulin: value));

  /// Setzt die globale Kohlenhydrat-Einheit (BE/KE).
  Future<void> setCarbUnit(CarbUnit unit) async => _update((s) => s.copyWith(carbUnit: unit));

  /// Setzt den FPE-Faktor (kann `null` sein).
  Future<void> setFpeFactor(double? fpeFactor) async => _update((s) => s.copyWith(fpeFactor: fpeFactor));

  /// Setzt die Startzeit eines Zeitblocks.
  Future<void> setBlockStart(InsulinBlockId id, TimeOfDay start) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setStart(s.insulinFactors, id, start)));
  }

  /// Setzt die Endzeit eines Zeitblocks (intern Startzeit des Folgeblocks).
  Future<void> setBlockEnd(InsulinBlockId id, TimeOfDay end) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setEnd(s.insulinFactors, id, end)));
  }

  /// Setzt den Insulinfaktor eines Zeitblocks.
  Future<void> setBlockFactor(InsulinBlockId id, double factor) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setFactor(s.insulinFactors, id, factor)));
  }

  /// Zentrale Update-Hilfsmethode.
  /// - Wendet eine Transformation auf die aktuellen Settings an
  /// - Normalisiert den Zeitplan
  /// - Persistiert die Änderungen
  /// - Aktualisiert den State
  Future<void> _update(UserSettings Function(UserSettings) cb) async {
    final current = state.value;
    if (current == null) return;

    final updated = _ensureNormalized(cb(current));
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }
}

/// Provider für den asynchronen Zugriff auf [UserSettings].
final userSettingsNotifierProvider =
    AsyncNotifierProvider<UserSettingsAsyncNotifier, UserSettings>(() => UserSettingsAsyncNotifier());
