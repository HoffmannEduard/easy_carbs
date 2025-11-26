import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/repositories/user_settings_repository_drift.dart';
import 'package:easy_carbs/domain/i_repo/i_user_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSettingsDaoProvider = Provider<UserSettingsDao>((ref) {
  final db = ref.watch(driftDbProvider);
  return UserSettingsDao(db);
});

final userSettingsRepositoryProvider = Provider<IUserSettingsRepository>((ref) {
  final dao = ref.watch(userSettingsDaoProvider);
  return UserSettingsRepo(dao);
});