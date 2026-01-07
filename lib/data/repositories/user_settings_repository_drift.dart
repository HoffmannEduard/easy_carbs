import 'package:drift/drift.dart';
import 'package:easy_carbs/data/db/drift_database.dart';

import '../db/drift_daos/user_settings_dao.dart';
import '../mappers/user_settings_mapper.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/entities/time_based_insulin_factor.dart';
import '../../domain/i_repo/i_user_settings_repository.dart';

class UserSettingsRepositoryDrift implements IUserSettingsRepository {
  final UserSettingsDao _dao;

  UserSettingsRepositoryDrift(this._dao);

  @override
  Future<UserSettings?> getSettings() async {
    final result = await _dao.getSettings();
    if (result == null) return null;
    return UserSettingsMapper.fromDrift(result.settings, result.insulinFactors);
  }

  @override
  Stream<UserSettings?> watchSettings() {
    return _dao.watchSettings().map((result) {
      if (result == null) return null;
      return UserSettingsMapper.fromDrift(result.settings, result.insulinFactors);
    });
  }

  @override
  Future<void> saveSettings(UserSettings settings) async {
    final companions = UserSettingsMapper.toDrift(settings);
    await _dao.saveSettings(
      companions['settings'] as UserSettingsTableCompanion,
      companions['factors'] as List<TimeBasedInsulinFactorsTableCompanion>,
    );
  }

  @override
  Future<void> addInsulinFactor(TimeBasedInsulinFactor factor) async {
    await _dao.addOrUpdateFactor(TimeBasedInsulinFactorsTableCompanion(
      id: Value(factor.id),
      userSettingsId: Value('user'),
      startTimeMinutes: Value(factor.startTime.hour * 60 + factor.startTime.minute),
      endTimeMinutes: Value(factor.endTime.hour * 60 + factor.endTime.minute),
      insulinFactor: Value(factor.insulinFactor),
    ));
  }

  @override
  Future<void> deleteInsulinFactor(String factorId) async {
    await _dao.deleteFactor(factorId);
  }
}
