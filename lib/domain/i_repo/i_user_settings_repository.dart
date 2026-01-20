import '../../domain/entities/user_settings.dart';

abstract class IUserSettingsRepository {
  /// Gibt die UserSettings zurück (oder null, falls noch keine existieren)
  Future<UserSettings?> getSettings();

  /// Gibt einen Stream auf die UserSettings zurück (reactive)
  Stream<UserSettings?> watchSettings();

  /// Speichert oder aktualisiert die UserSettings inklusive aller InsulinFactors
  Future<void> saveSettings(UserSettings settings);

}
