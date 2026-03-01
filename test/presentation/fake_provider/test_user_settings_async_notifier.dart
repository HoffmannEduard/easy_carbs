import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';

class TestUserSettingsAsyncNotifier extends UserSettingsAsyncNotifier {
  UserSettings _current;

  TestUserSettingsAsyncNotifier(this._current);

  @override
  Future<UserSettings> build() async {
    state = AsyncValue.data(_current);
    return _current;
  }

  @override
  Future<void> toggleShowInsulin(bool value) async {
    _current = _current.copyWith(showInsulin: value);
    state = AsyncValue.data(_current);
  }

  @override
  Future<void> setFpeFactor(double? value) async {
    _current = _current.copyWith(fpeFactor: value);
    state = AsyncValue.data(_current);
  }

  @override
  Future<void> setCarbUnit(CarbUnit unit) async {
    _current = _current.copyWith(carbUnit: unit);
    state = AsyncValue.data(_current);
  }
}