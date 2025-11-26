import 'package:easy_carbs/domain/entities/user_settings.dart';

abstract class IUserSettingsRepository {
  
  Future<UserSettings?> loadSettings();
  
  Future<void> saveSettings(UserSettings settings);
}