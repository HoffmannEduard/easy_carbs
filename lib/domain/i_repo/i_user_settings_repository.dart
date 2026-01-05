import 'package:easy_carbs/domain/entities/user_settings.dart';

abstract class IUserSettingsRepository {

  Stream<UserSettings> watchSettings();
  
  Future<UserSettings?> loadSettings();
  
  Future<void> saveSettings(UserSettings settings);

  Future<void> updateSettings(UserSettings settings);
  
}