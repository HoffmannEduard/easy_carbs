import '../../domain/entities/user_settings.dart';
import '../../domain/entities/time_based_insulin_factor.dart';

abstract class IUserSettingsRepository {
  /// Gibt die UserSettings zurück (oder null, falls noch keine existieren)
  Future<UserSettings?> getSettings();

  /// Gibt einen Stream auf die UserSettings zurück (reactive)
  Stream<UserSettings?> watchSettings();

  /// Speichert oder aktualisiert die UserSettings inklusive aller InsulinFactors
  Future<void> saveSettings(UserSettings settings);

  /// Fügt einen einzelnen TimeBasedInsulinFactor hinzu oder aktualisiert ihn
  Future<void> addInsulinFactor(TimeBasedInsulinFactor factor);

  /// Löscht einen einzelnen TimeBasedInsulinFactor
  Future<void> deleteInsulinFactor(String factorId);
}
