import 'package:easy_carbs/data/db/drift_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// App Datenbank wird bereitgestellt und automatisch geschlossen, wenn sie nicht gebraucht wird
final driftDbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    db.close();
  });
  return db;
});





