import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';

// Provider für den Notifier
final userSettingsNotifierProvider = AsyncNotifierProvider<UserSettingsAsyncNotifier, UserSettings>(() {
      return UserSettingsAsyncNotifier();
    });

class UserSettingsAsyncNotifier extends AsyncNotifier<UserSettings> {
  
  //IRepo-Instanz über den Provider beziehen
  late final _repo = ref.read(userSettingsRepositoryProvider);

  @override
  Future<UserSettings> build() async {  
    final settingsFromDb = await _repo.loadSettings();
    //checken ob settings in db, sonst default Settings erstellen und speichern
    if (settingsFromDb != null) {
      return settingsFromDb;
    } else {
      final defaultSettings = UserSettings(
        id: 'one_and_only',
        carbUnit: CarbUnit.gramm,
        showFpe: true
      );
      await _repo.saveSettings(defaultSettings);
      return defaultSettings;
    }
  }

  Future<void> toggleShowFpe(bool value) async {
    final current = state.value;
    final updated = current!.copyWith(showFpe: value);
    await _repo.updateSettings(updated);
    state = AsyncData(updated);
  }
  


}
