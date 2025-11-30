import 'package:easy_carbs/data/db/drift_daos/meal_dao.dart';
import 'package:easy_carbs/data/db/drift_daos/user_settings_dao.dart';
import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_carbs/data/repositories/meal_repository_drift.dart';
import 'package:easy_carbs/data/repositories/user_settings_repository_drift.dart';
import 'package:easy_carbs/domain/i_repo/i_meal_repository.dart';
import 'package:easy_carbs/domain/i_repo/i_user_settings_repository.dart';


// App Datenbank wird bereitgestellt und automatisch geschlossen, wenn sie nicht gebraucht wird
final driftDbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});

// CRUD-Operationen werden über DAO-Klasse ausgeführt, Datenbank wird injiziert
final mealDaoProvider = Provider<MealDao>((ref) {
  final db = ref.watch(driftDbProvider);
  return MealDao(db);
});

// Verbindung des IRepo mit der konkreten Implementierung (MealRepositoryDrift) und der CRUD-Operationen über DAO
final mealRepositoryProvider = Provider<IMealRepository>((ref) {
  final dao = ref.watch(mealDaoProvider); 
  return MealRepositoryDrift(dao);
});

// StreamProvider um alle Mahlzeiten zu beobachten, wird über IRepo aufgerufen
// ggf. über Wechsel zu AsyncNotifierProvider nachdenken, wenn mehr Logik benötigt wird
final mealsStreamProvider = StreamProvider<List<Meal>>((ref) {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.watchAllMeals();
});

// CRUD-Operationen werden über DAO-Klasse ausgeführt, Datenbank wird injiziert
final userSettingsDaoProvider = Provider<UserSettingsDao>((ref) {
  final db = ref.watch(driftDbProvider);
  return UserSettingsDao(db);
});

// Verbindung des IRepo mit der konkreten Implementierung (MealRepositoryDrift) und der CRUD-Operationen über DAO
final userSettingsRepositoryProvider = Provider<IUserSettingsRepository>((ref) {
  final dao = ref.watch(userSettingsDaoProvider);
  return UserSettingsRepo(dao);
});

final userSettingsProvider = StreamProvider<UserSettings>((ref) {
  final repo = ref.watch(userSettingsRepositoryProvider);
  return repo.watchSettings();
});

