import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSettingsAsyncNotifier extends AsyncNotifier<UserSettings> {
  late final _repo = ref.read(userSettingsRepositoryProvider);

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

  UserSettings _ensureNormalized(UserSettings s) {
    final normalized = FixedInsulinSchedule.normalize(s.insulinFactors);
    return s.copyWith(insulinFactors: normalized);
  }

  Future<void> toggleShowInsulin(bool value) async => _update((s) => s.copyWith(showInsulin: value));

  Future<void> setCarbUnit(CarbUnit unit) async => _update((s) => s.copyWith(carbUnit: unit));

  Future<void> setFpeFactor(double? fpeFactor) async => _update((s) => s.copyWith(fpeFactor: fpeFactor));

  Future<void> setBlockStart(InsulinBlockId id, TimeOfDay start) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setStart(s.insulinFactors, id, start)));
  }

  Future<void> setBlockEnd(InsulinBlockId id, TimeOfDay end) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setEnd(s.insulinFactors, id, end)));
  }

  Future<void> setBlockFactor(InsulinBlockId id, double factor) async {
    await _update((s) => s.copyWith(insulinFactors: FixedInsulinSchedule.setFactor(s.insulinFactors, id, factor)));
  }

  Future<void> _update(UserSettings Function(UserSettings) cb) async {
    final current = state.value;
    if (current == null) return;

    final updated = _ensureNormalized(cb(current));
    await _repo.saveSettings(updated);
    state = AsyncData(updated);
  }
}

final userSettingsNotifierProvider =
    AsyncNotifierProvider<UserSettingsAsyncNotifier, UserSettings>(() => UserSettingsAsyncNotifier());
