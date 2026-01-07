import 'package:drift/drift.dart';
import '../type_converters/carb_unit_converter.dart';

class UserSettingsTable extends Table {

  TextColumn get id => text().clientDefault(() => 'user')(); 
  TextColumn get carbUnit => text().map(const CarbUnitConverter())();
  BoolColumn get showFpe => boolean().withDefault(const Constant(true))();
  RealColumn get fpeFactor => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
