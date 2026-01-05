import 'package:drift/drift.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';

class CarbUnitConverter extends TypeConverter<CarbUnit, String> {
  const CarbUnitConverter();

  @override
  CarbUnit fromSql(String fromDb) {
    return CarbUnit.values.firstWhere((e) => e.toString() == fromDb);
  }

  @override
  String toSql(CarbUnit value) => value.toString();
}
