import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/mappers/user_settings_mapper.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/i_repo/i_user_settings_repository.dart';

class UserSettingsRepo implements IUserSettingsRepository {
  final UserSettingsDao dao;

  UserSettingsRepo(this.dao);

  @override
  Stream<UserSettings> watchSettings() {
    return dao.watchSettings().map(
      (row) => row != null ? UserSettingsMapper.fromTable(row) : throw Exception('No user settings found'),
    );
  }

  @override
  Future<UserSettings?> loadSettings() async {
    final row = await dao.loadSettings();
    if (row == null) return null;
    return UserSettingsMapper.fromTable(row);
  }

  @override
  Future<void> saveSettings(UserSettings settings) {
    final row = UserSettingsMapper.toTable(settings);
    return dao.saveSettings(row);
  }

  @override
  Future<void> updateSettings(UserSettings settings) async {
    final row = UserSettingsMapper.toTable(settings);
    return dao.updateSettings(row);
  }


}