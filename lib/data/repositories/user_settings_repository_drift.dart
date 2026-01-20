import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/data/mappers/user_settings_mapper.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/i_repo/i_user_settings_repository.dart';

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
}
