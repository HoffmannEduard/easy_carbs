// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $NutritionsTableTable extends NutritionsTable
    with TableInfo<$NutritionsTableTable, NutritionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sugarMeta = const VerificationMeta('sugar');
  @override
  late final GeneratedColumn<double> sugar = GeneratedColumn<double>(
    'sugar',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saturatedFatMeta = const VerificationMeta(
    'saturatedFat',
  );
  @override
  late final GeneratedColumn<double> saturatedFat = GeneratedColumn<double>(
    'saturated_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightOnePieceMeta = const VerificationMeta(
    'weightOnePiece',
  );
  @override
  late final GeneratedColumn<double> weightOnePiece = GeneratedColumn<double>(
    'weight_one_piece',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carbs,
    sugar,
    fat,
    saturatedFat,
    protein,
    weightOnePiece,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutritions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('sugar')) {
      context.handle(
        _sugarMeta,
        sugar.isAcceptableOrUnknown(data['sugar']!, _sugarMeta),
      );
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('saturated_fat')) {
      context.handle(
        _saturatedFatMeta,
        saturatedFat.isAcceptableOrUnknown(
          data['saturated_fat']!,
          _saturatedFatMeta,
        ),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('weight_one_piece')) {
      context.handle(
        _weightOnePieceMeta,
        weightOnePiece.isAcceptableOrUnknown(
          data['weight_one_piece']!,
          _weightOnePieceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      ),
      sugar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sugar'],
      ),
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      ),
      saturatedFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saturated_fat'],
      ),
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      ),
      weightOnePiece: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_one_piece'],
      ),
    );
  }

  @override
  $NutritionsTableTable createAlias(String alias) {
    return $NutritionsTableTable(attachedDatabase, alias);
  }
}

class NutritionsTableData extends DataClass
    implements Insertable<NutritionsTableData> {
  final String id;
  final double? carbs;
  final double? sugar;
  final double? fat;
  final double? saturatedFat;
  final double? protein;
  final double? weightOnePiece;
  const NutritionsTableData({
    required this.id,
    this.carbs,
    this.sugar,
    this.fat,
    this.saturatedFat,
    this.protein,
    this.weightOnePiece,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || carbs != null) {
      map['carbs'] = Variable<double>(carbs);
    }
    if (!nullToAbsent || sugar != null) {
      map['sugar'] = Variable<double>(sugar);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    if (!nullToAbsent || saturatedFat != null) {
      map['saturated_fat'] = Variable<double>(saturatedFat);
    }
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || weightOnePiece != null) {
      map['weight_one_piece'] = Variable<double>(weightOnePiece);
    }
    return map;
  }

  NutritionsTableCompanion toCompanion(bool nullToAbsent) {
    return NutritionsTableCompanion(
      id: Value(id),
      carbs:
          carbs == null && nullToAbsent ? const Value.absent() : Value(carbs),
      sugar:
          sugar == null && nullToAbsent ? const Value.absent() : Value(sugar),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      saturatedFat:
          saturatedFat == null && nullToAbsent
              ? const Value.absent()
              : Value(saturatedFat),
      protein:
          protein == null && nullToAbsent
              ? const Value.absent()
              : Value(protein),
      weightOnePiece:
          weightOnePiece == null && nullToAbsent
              ? const Value.absent()
              : Value(weightOnePiece),
    );
  }

  factory NutritionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionsTableData(
      id: serializer.fromJson<String>(json['id']),
      carbs: serializer.fromJson<double?>(json['carbs']),
      sugar: serializer.fromJson<double?>(json['sugar']),
      fat: serializer.fromJson<double?>(json['fat']),
      saturatedFat: serializer.fromJson<double?>(json['saturatedFat']),
      protein: serializer.fromJson<double?>(json['protein']),
      weightOnePiece: serializer.fromJson<double?>(json['weightOnePiece']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'carbs': serializer.toJson<double?>(carbs),
      'sugar': serializer.toJson<double?>(sugar),
      'fat': serializer.toJson<double?>(fat),
      'saturatedFat': serializer.toJson<double?>(saturatedFat),
      'protein': serializer.toJson<double?>(protein),
      'weightOnePiece': serializer.toJson<double?>(weightOnePiece),
    };
  }

  NutritionsTableData copyWith({
    String? id,
    Value<double?> carbs = const Value.absent(),
    Value<double?> sugar = const Value.absent(),
    Value<double?> fat = const Value.absent(),
    Value<double?> saturatedFat = const Value.absent(),
    Value<double?> protein = const Value.absent(),
    Value<double?> weightOnePiece = const Value.absent(),
  }) => NutritionsTableData(
    id: id ?? this.id,
    carbs: carbs.present ? carbs.value : this.carbs,
    sugar: sugar.present ? sugar.value : this.sugar,
    fat: fat.present ? fat.value : this.fat,
    saturatedFat: saturatedFat.present ? saturatedFat.value : this.saturatedFat,
    protein: protein.present ? protein.value : this.protein,
    weightOnePiece:
        weightOnePiece.present ? weightOnePiece.value : this.weightOnePiece,
  );
  NutritionsTableData copyWithCompanion(NutritionsTableCompanion data) {
    return NutritionsTableData(
      id: data.id.present ? data.id.value : this.id,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      sugar: data.sugar.present ? data.sugar.value : this.sugar,
      fat: data.fat.present ? data.fat.value : this.fat,
      saturatedFat:
          data.saturatedFat.present
              ? data.saturatedFat.value
              : this.saturatedFat,
      protein: data.protein.present ? data.protein.value : this.protein,
      weightOnePiece:
          data.weightOnePiece.present
              ? data.weightOnePiece.value
              : this.weightOnePiece,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionsTableData(')
          ..write('id: $id, ')
          ..write('carbs: $carbs, ')
          ..write('sugar: $sugar, ')
          ..write('fat: $fat, ')
          ..write('saturatedFat: $saturatedFat, ')
          ..write('protein: $protein, ')
          ..write('weightOnePiece: $weightOnePiece')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, carbs, sugar, fat, saturatedFat, protein, weightOnePiece);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionsTableData &&
          other.id == this.id &&
          other.carbs == this.carbs &&
          other.sugar == this.sugar &&
          other.fat == this.fat &&
          other.saturatedFat == this.saturatedFat &&
          other.protein == this.protein &&
          other.weightOnePiece == this.weightOnePiece);
}

class NutritionsTableCompanion extends UpdateCompanion<NutritionsTableData> {
  final Value<String> id;
  final Value<double?> carbs;
  final Value<double?> sugar;
  final Value<double?> fat;
  final Value<double?> saturatedFat;
  final Value<double?> protein;
  final Value<double?> weightOnePiece;
  final Value<int> rowid;
  const NutritionsTableCompanion({
    this.id = const Value.absent(),
    this.carbs = const Value.absent(),
    this.sugar = const Value.absent(),
    this.fat = const Value.absent(),
    this.saturatedFat = const Value.absent(),
    this.protein = const Value.absent(),
    this.weightOnePiece = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionsTableCompanion.insert({
    required String id,
    this.carbs = const Value.absent(),
    this.sugar = const Value.absent(),
    this.fat = const Value.absent(),
    this.saturatedFat = const Value.absent(),
    this.protein = const Value.absent(),
    this.weightOnePiece = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<NutritionsTableData> custom({
    Expression<String>? id,
    Expression<double>? carbs,
    Expression<double>? sugar,
    Expression<double>? fat,
    Expression<double>? saturatedFat,
    Expression<double>? protein,
    Expression<double>? weightOnePiece,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carbs != null) 'carbs': carbs,
      if (sugar != null) 'sugar': sugar,
      if (fat != null) 'fat': fat,
      if (saturatedFat != null) 'saturated_fat': saturatedFat,
      if (protein != null) 'protein': protein,
      if (weightOnePiece != null) 'weight_one_piece': weightOnePiece,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionsTableCompanion copyWith({
    Value<String>? id,
    Value<double?>? carbs,
    Value<double?>? sugar,
    Value<double?>? fat,
    Value<double?>? saturatedFat,
    Value<double?>? protein,
    Value<double?>? weightOnePiece,
    Value<int>? rowid,
  }) {
    return NutritionsTableCompanion(
      id: id ?? this.id,
      carbs: carbs ?? this.carbs,
      sugar: sugar ?? this.sugar,
      fat: fat ?? this.fat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      protein: protein ?? this.protein,
      weightOnePiece: weightOnePiece ?? this.weightOnePiece,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (sugar.present) {
      map['sugar'] = Variable<double>(sugar.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (saturatedFat.present) {
      map['saturated_fat'] = Variable<double>(saturatedFat.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (weightOnePiece.present) {
      map['weight_one_piece'] = Variable<double>(weightOnePiece.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionsTableCompanion(')
          ..write('id: $id, ')
          ..write('carbs: $carbs, ')
          ..write('sugar: $sugar, ')
          ..write('fat: $fat, ')
          ..write('saturatedFat: $saturatedFat, ')
          ..write('protein: $protein, ')
          ..write('weightOnePiece: $weightOnePiece, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealsTableTable extends MealsTable
    with TableInfo<$MealsTableTable, MealsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbUnitMeta = const VerificationMeta(
    'carbUnit',
  );
  @override
  late final GeneratedColumn<String> carbUnit = GeneratedColumn<String>(
    'carb_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsInUnitMeta = const VerificationMeta(
    'carbsInUnit',
  );
  @override
  late final GeneratedColumn<double> carbsInUnit = GeneratedColumn<double>(
    'carbs_in_unit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fpeMeta = const VerificationMeta('fpe');
  @override
  late final GeneratedColumn<double> fpe = GeneratedColumn<double>(
    'fpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nutritionIdMeta = const VerificationMeta(
    'nutritionId',
  );
  @override
  late final GeneratedColumn<String> nutritionId = GeneratedColumn<String>(
    'nutrition_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutritions_table (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _portionsizeMeta = const VerificationMeta(
    'portionsize',
  );
  @override
  late final GeneratedColumn<double> portionsize = GeneratedColumn<double>(
    'portionsize',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _portionUnitMeta = const VerificationMeta(
    'portionUnit',
  );
  @override
  late final GeneratedColumn<String> portionUnit = GeneratedColumn<String>(
    'portion_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriesMeta = const VerificationMeta(
    'categories',
  );
  @override
  late final GeneratedColumn<String> categories = GeneratedColumn<String>(
    'categories',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carbUnit,
    name,
    imagePath,
    timestamp,
    carbsInUnit,
    fpe,
    nutritionId,
    location,
    portionsize,
    portionUnit,
    note,
    categories,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('carb_unit')) {
      context.handle(
        _carbUnitMeta,
        carbUnit.isAcceptableOrUnknown(data['carb_unit']!, _carbUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_carbUnitMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('carbs_in_unit')) {
      context.handle(
        _carbsInUnitMeta,
        carbsInUnit.isAcceptableOrUnknown(
          data['carbs_in_unit']!,
          _carbsInUnitMeta,
        ),
      );
    }
    if (data.containsKey('fpe')) {
      context.handle(
        _fpeMeta,
        fpe.isAcceptableOrUnknown(data['fpe']!, _fpeMeta),
      );
    }
    if (data.containsKey('nutrition_id')) {
      context.handle(
        _nutritionIdMeta,
        nutritionId.isAcceptableOrUnknown(
          data['nutrition_id']!,
          _nutritionIdMeta,
        ),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('portionsize')) {
      context.handle(
        _portionsizeMeta,
        portionsize.isAcceptableOrUnknown(
          data['portionsize']!,
          _portionsizeMeta,
        ),
      );
    }
    if (data.containsKey('portion_unit')) {
      context.handle(
        _portionUnitMeta,
        portionUnit.isAcceptableOrUnknown(
          data['portion_unit']!,
          _portionUnitMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('categories')) {
      context.handle(
        _categoriesMeta,
        categories.isAcceptableOrUnknown(data['categories']!, _categoriesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      carbUnit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}carb_unit'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
      carbsInUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_in_unit'],
      ),
      fpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fpe'],
      ),
      nutritionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition_id'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      portionsize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}portionsize'],
      ),
      portionUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portion_unit'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      categories: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categories'],
      ),
    );
  }

  @override
  $MealsTableTable createAlias(String alias) {
    return $MealsTableTable(attachedDatabase, alias);
  }
}

class MealsTableData extends DataClass implements Insertable<MealsTableData> {
  final String id;
  final String carbUnit;
  final String name;
  final String? imagePath;
  final DateTime timestamp;
  final double? carbsInUnit;
  final double? fpe;
  final String? nutritionId;
  final String? location;
  final double? portionsize;
  final String? portionUnit;
  final String? note;
  final String? categories;
  const MealsTableData({
    required this.id,
    required this.carbUnit,
    required this.name,
    this.imagePath,
    required this.timestamp,
    this.carbsInUnit,
    this.fpe,
    this.nutritionId,
    this.location,
    this.portionsize,
    this.portionUnit,
    this.note,
    this.categories,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['carb_unit'] = Variable<String>(carbUnit);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || carbsInUnit != null) {
      map['carbs_in_unit'] = Variable<double>(carbsInUnit);
    }
    if (!nullToAbsent || fpe != null) {
      map['fpe'] = Variable<double>(fpe);
    }
    if (!nullToAbsent || nutritionId != null) {
      map['nutrition_id'] = Variable<String>(nutritionId);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || portionsize != null) {
      map['portionsize'] = Variable<double>(portionsize);
    }
    if (!nullToAbsent || portionUnit != null) {
      map['portion_unit'] = Variable<String>(portionUnit);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || categories != null) {
      map['categories'] = Variable<String>(categories);
    }
    return map;
  }

  MealsTableCompanion toCompanion(bool nullToAbsent) {
    return MealsTableCompanion(
      id: Value(id),
      carbUnit: Value(carbUnit),
      name: Value(name),
      imagePath:
          imagePath == null && nullToAbsent
              ? const Value.absent()
              : Value(imagePath),
      timestamp: Value(timestamp),
      carbsInUnit:
          carbsInUnit == null && nullToAbsent
              ? const Value.absent()
              : Value(carbsInUnit),
      fpe: fpe == null && nullToAbsent ? const Value.absent() : Value(fpe),
      nutritionId:
          nutritionId == null && nullToAbsent
              ? const Value.absent()
              : Value(nutritionId),
      location:
          location == null && nullToAbsent
              ? const Value.absent()
              : Value(location),
      portionsize:
          portionsize == null && nullToAbsent
              ? const Value.absent()
              : Value(portionsize),
      portionUnit:
          portionUnit == null && nullToAbsent
              ? const Value.absent()
              : Value(portionUnit),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      categories:
          categories == null && nullToAbsent
              ? const Value.absent()
              : Value(categories),
    );
  }

  factory MealsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealsTableData(
      id: serializer.fromJson<String>(json['id']),
      carbUnit: serializer.fromJson<String>(json['carbUnit']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      carbsInUnit: serializer.fromJson<double?>(json['carbsInUnit']),
      fpe: serializer.fromJson<double?>(json['fpe']),
      nutritionId: serializer.fromJson<String?>(json['nutritionId']),
      location: serializer.fromJson<String?>(json['location']),
      portionsize: serializer.fromJson<double?>(json['portionsize']),
      portionUnit: serializer.fromJson<String?>(json['portionUnit']),
      note: serializer.fromJson<String?>(json['note']),
      categories: serializer.fromJson<String?>(json['categories']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'carbUnit': serializer.toJson<String>(carbUnit),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String?>(imagePath),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'carbsInUnit': serializer.toJson<double?>(carbsInUnit),
      'fpe': serializer.toJson<double?>(fpe),
      'nutritionId': serializer.toJson<String?>(nutritionId),
      'location': serializer.toJson<String?>(location),
      'portionsize': serializer.toJson<double?>(portionsize),
      'portionUnit': serializer.toJson<String?>(portionUnit),
      'note': serializer.toJson<String?>(note),
      'categories': serializer.toJson<String?>(categories),
    };
  }

  MealsTableData copyWith({
    String? id,
    String? carbUnit,
    String? name,
    Value<String?> imagePath = const Value.absent(),
    DateTime? timestamp,
    Value<double?> carbsInUnit = const Value.absent(),
    Value<double?> fpe = const Value.absent(),
    Value<String?> nutritionId = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<double?> portionsize = const Value.absent(),
    Value<String?> portionUnit = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> categories = const Value.absent(),
  }) => MealsTableData(
    id: id ?? this.id,
    carbUnit: carbUnit ?? this.carbUnit,
    name: name ?? this.name,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    timestamp: timestamp ?? this.timestamp,
    carbsInUnit: carbsInUnit.present ? carbsInUnit.value : this.carbsInUnit,
    fpe: fpe.present ? fpe.value : this.fpe,
    nutritionId: nutritionId.present ? nutritionId.value : this.nutritionId,
    location: location.present ? location.value : this.location,
    portionsize: portionsize.present ? portionsize.value : this.portionsize,
    portionUnit: portionUnit.present ? portionUnit.value : this.portionUnit,
    note: note.present ? note.value : this.note,
    categories: categories.present ? categories.value : this.categories,
  );
  MealsTableData copyWithCompanion(MealsTableCompanion data) {
    return MealsTableData(
      id: data.id.present ? data.id.value : this.id,
      carbUnit: data.carbUnit.present ? data.carbUnit.value : this.carbUnit,
      name: data.name.present ? data.name.value : this.name,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      carbsInUnit:
          data.carbsInUnit.present ? data.carbsInUnit.value : this.carbsInUnit,
      fpe: data.fpe.present ? data.fpe.value : this.fpe,
      nutritionId:
          data.nutritionId.present ? data.nutritionId.value : this.nutritionId,
      location: data.location.present ? data.location.value : this.location,
      portionsize:
          data.portionsize.present ? data.portionsize.value : this.portionsize,
      portionUnit:
          data.portionUnit.present ? data.portionUnit.value : this.portionUnit,
      note: data.note.present ? data.note.value : this.note,
      categories:
          data.categories.present ? data.categories.value : this.categories,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealsTableData(')
          ..write('id: $id, ')
          ..write('carbUnit: $carbUnit, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('carbsInUnit: $carbsInUnit, ')
          ..write('fpe: $fpe, ')
          ..write('nutritionId: $nutritionId, ')
          ..write('location: $location, ')
          ..write('portionsize: $portionsize, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('note: $note, ')
          ..write('categories: $categories')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carbUnit,
    name,
    imagePath,
    timestamp,
    carbsInUnit,
    fpe,
    nutritionId,
    location,
    portionsize,
    portionUnit,
    note,
    categories,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealsTableData &&
          other.id == this.id &&
          other.carbUnit == this.carbUnit &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.timestamp == this.timestamp &&
          other.carbsInUnit == this.carbsInUnit &&
          other.fpe == this.fpe &&
          other.nutritionId == this.nutritionId &&
          other.location == this.location &&
          other.portionsize == this.portionsize &&
          other.portionUnit == this.portionUnit &&
          other.note == this.note &&
          other.categories == this.categories);
}

class MealsTableCompanion extends UpdateCompanion<MealsTableData> {
  final Value<String> id;
  final Value<String> carbUnit;
  final Value<String> name;
  final Value<String?> imagePath;
  final Value<DateTime> timestamp;
  final Value<double?> carbsInUnit;
  final Value<double?> fpe;
  final Value<String?> nutritionId;
  final Value<String?> location;
  final Value<double?> portionsize;
  final Value<String?> portionUnit;
  final Value<String?> note;
  final Value<String?> categories;
  final Value<int> rowid;
  const MealsTableCompanion({
    this.id = const Value.absent(),
    this.carbUnit = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.carbsInUnit = const Value.absent(),
    this.fpe = const Value.absent(),
    this.nutritionId = const Value.absent(),
    this.location = const Value.absent(),
    this.portionsize = const Value.absent(),
    this.portionUnit = const Value.absent(),
    this.note = const Value.absent(),
    this.categories = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsTableCompanion.insert({
    required String id,
    required String carbUnit,
    required String name,
    this.imagePath = const Value.absent(),
    required DateTime timestamp,
    this.carbsInUnit = const Value.absent(),
    this.fpe = const Value.absent(),
    this.nutritionId = const Value.absent(),
    this.location = const Value.absent(),
    this.portionsize = const Value.absent(),
    this.portionUnit = const Value.absent(),
    this.note = const Value.absent(),
    this.categories = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       carbUnit = Value(carbUnit),
       name = Value(name),
       timestamp = Value(timestamp);
  static Insertable<MealsTableData> custom({
    Expression<String>? id,
    Expression<String>? carbUnit,
    Expression<String>? name,
    Expression<String>? imagePath,
    Expression<DateTime>? timestamp,
    Expression<double>? carbsInUnit,
    Expression<double>? fpe,
    Expression<String>? nutritionId,
    Expression<String>? location,
    Expression<double>? portionsize,
    Expression<String>? portionUnit,
    Expression<String>? note,
    Expression<String>? categories,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carbUnit != null) 'carb_unit': carbUnit,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (timestamp != null) 'timestamp': timestamp,
      if (carbsInUnit != null) 'carbs_in_unit': carbsInUnit,
      if (fpe != null) 'fpe': fpe,
      if (nutritionId != null) 'nutrition_id': nutritionId,
      if (location != null) 'location': location,
      if (portionsize != null) 'portionsize': portionsize,
      if (portionUnit != null) 'portion_unit': portionUnit,
      if (note != null) 'note': note,
      if (categories != null) 'categories': categories,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? carbUnit,
    Value<String>? name,
    Value<String?>? imagePath,
    Value<DateTime>? timestamp,
    Value<double?>? carbsInUnit,
    Value<double?>? fpe,
    Value<String?>? nutritionId,
    Value<String?>? location,
    Value<double?>? portionsize,
    Value<String?>? portionUnit,
    Value<String?>? note,
    Value<String?>? categories,
    Value<int>? rowid,
  }) {
    return MealsTableCompanion(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      carbsInUnit: carbsInUnit ?? this.carbsInUnit,
      fpe: fpe ?? this.fpe,
      nutritionId: nutritionId ?? this.nutritionId,
      location: location ?? this.location,
      portionsize: portionsize ?? this.portionsize,
      portionUnit: portionUnit ?? this.portionUnit,
      note: note ?? this.note,
      categories: categories ?? this.categories,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (carbUnit.present) {
      map['carb_unit'] = Variable<String>(carbUnit.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (carbsInUnit.present) {
      map['carbs_in_unit'] = Variable<double>(carbsInUnit.value);
    }
    if (fpe.present) {
      map['fpe'] = Variable<double>(fpe.value);
    }
    if (nutritionId.present) {
      map['nutrition_id'] = Variable<String>(nutritionId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (portionsize.present) {
      map['portionsize'] = Variable<double>(portionsize.value);
    }
    if (portionUnit.present) {
      map['portion_unit'] = Variable<String>(portionUnit.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (categories.present) {
      map['categories'] = Variable<String>(categories.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsTableCompanion(')
          ..write('id: $id, ')
          ..write('carbUnit: $carbUnit, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('carbsInUnit: $carbsInUnit, ')
          ..write('fpe: $fpe, ')
          ..write('nutritionId: $nutritionId, ')
          ..write('location: $location, ')
          ..write('portionsize: $portionsize, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('note: $note, ')
          ..write('categories: $categories, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTableTable extends UserSettingsTable
    with TableInfo<$UserSettingsTableTable, UserSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => 'user',
  );
  @override
  late final GeneratedColumnWithTypeConverter<CarbUnit, String> carbUnit =
      GeneratedColumn<String>(
        'carb_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CarbUnit>($UserSettingsTableTable.$convertercarbUnit);
  static const VerificationMeta _showFpeMeta = const VerificationMeta(
    'showFpe',
  );
  @override
  late final GeneratedColumn<bool> showFpe = GeneratedColumn<bool>(
    'show_fpe',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_fpe" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _fpeFactorMeta = const VerificationMeta(
    'fpeFactor',
  );
  @override
  late final GeneratedColumn<double> fpeFactor = GeneratedColumn<double>(
    'fpe_factor',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, carbUnit, showFpe, fpeFactor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('show_fpe')) {
      context.handle(
        _showFpeMeta,
        showFpe.isAcceptableOrUnknown(data['show_fpe']!, _showFpeMeta),
      );
    }
    if (data.containsKey('fpe_factor')) {
      context.handle(
        _fpeFactorMeta,
        fpeFactor.isAcceptableOrUnknown(data['fpe_factor']!, _fpeFactorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      carbUnit: $UserSettingsTableTable.$convertercarbUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}carb_unit'],
        )!,
      ),
      showFpe:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}show_fpe'],
          )!,
      fpeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fpe_factor'],
      ),
    );
  }

  @override
  $UserSettingsTableTable createAlias(String alias) {
    return $UserSettingsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<CarbUnit, String> $convertercarbUnit =
      const CarbUnitConverter();
}

class UserSettingsTableData extends DataClass
    implements Insertable<UserSettingsTableData> {
  final String id;
  final CarbUnit carbUnit;
  final bool showFpe;
  final double? fpeFactor;
  const UserSettingsTableData({
    required this.id,
    required this.carbUnit,
    required this.showFpe,
    this.fpeFactor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['carb_unit'] = Variable<String>(
        $UserSettingsTableTable.$convertercarbUnit.toSql(carbUnit),
      );
    }
    map['show_fpe'] = Variable<bool>(showFpe);
    if (!nullToAbsent || fpeFactor != null) {
      map['fpe_factor'] = Variable<double>(fpeFactor);
    }
    return map;
  }

  UserSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsTableCompanion(
      id: Value(id),
      carbUnit: Value(carbUnit),
      showFpe: Value(showFpe),
      fpeFactor:
          fpeFactor == null && nullToAbsent
              ? const Value.absent()
              : Value(fpeFactor),
    );
  }

  factory UserSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsTableData(
      id: serializer.fromJson<String>(json['id']),
      carbUnit: serializer.fromJson<CarbUnit>(json['carbUnit']),
      showFpe: serializer.fromJson<bool>(json['showFpe']),
      fpeFactor: serializer.fromJson<double?>(json['fpeFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'carbUnit': serializer.toJson<CarbUnit>(carbUnit),
      'showFpe': serializer.toJson<bool>(showFpe),
      'fpeFactor': serializer.toJson<double?>(fpeFactor),
    };
  }

  UserSettingsTableData copyWith({
    String? id,
    CarbUnit? carbUnit,
    bool? showFpe,
    Value<double?> fpeFactor = const Value.absent(),
  }) => UserSettingsTableData(
    id: id ?? this.id,
    carbUnit: carbUnit ?? this.carbUnit,
    showFpe: showFpe ?? this.showFpe,
    fpeFactor: fpeFactor.present ? fpeFactor.value : this.fpeFactor,
  );
  UserSettingsTableData copyWithCompanion(UserSettingsTableCompanion data) {
    return UserSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      carbUnit: data.carbUnit.present ? data.carbUnit.value : this.carbUnit,
      showFpe: data.showFpe.present ? data.showFpe.value : this.showFpe,
      fpeFactor: data.fpeFactor.present ? data.fpeFactor.value : this.fpeFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsTableData(')
          ..write('id: $id, ')
          ..write('carbUnit: $carbUnit, ')
          ..write('showFpe: $showFpe, ')
          ..write('fpeFactor: $fpeFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, carbUnit, showFpe, fpeFactor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsTableData &&
          other.id == this.id &&
          other.carbUnit == this.carbUnit &&
          other.showFpe == this.showFpe &&
          other.fpeFactor == this.fpeFactor);
}

class UserSettingsTableCompanion
    extends UpdateCompanion<UserSettingsTableData> {
  final Value<String> id;
  final Value<CarbUnit> carbUnit;
  final Value<bool> showFpe;
  final Value<double?> fpeFactor;
  final Value<int> rowid;
  const UserSettingsTableCompanion({
    this.id = const Value.absent(),
    this.carbUnit = const Value.absent(),
    this.showFpe = const Value.absent(),
    this.fpeFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required CarbUnit carbUnit,
    this.showFpe = const Value.absent(),
    this.fpeFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : carbUnit = Value(carbUnit);
  static Insertable<UserSettingsTableData> custom({
    Expression<String>? id,
    Expression<String>? carbUnit,
    Expression<bool>? showFpe,
    Expression<double>? fpeFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carbUnit != null) 'carb_unit': carbUnit,
      if (showFpe != null) 'show_fpe': showFpe,
      if (fpeFactor != null) 'fpe_factor': fpeFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<CarbUnit>? carbUnit,
    Value<bool>? showFpe,
    Value<double?>? fpeFactor,
    Value<int>? rowid,
  }) {
    return UserSettingsTableCompanion(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      showFpe: showFpe ?? this.showFpe,
      fpeFactor: fpeFactor ?? this.fpeFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (carbUnit.present) {
      map['carb_unit'] = Variable<String>(
        $UserSettingsTableTable.$convertercarbUnit.toSql(carbUnit.value),
      );
    }
    if (showFpe.present) {
      map['show_fpe'] = Variable<bool>(showFpe.value);
    }
    if (fpeFactor.present) {
      map['fpe_factor'] = Variable<double>(fpeFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('carbUnit: $carbUnit, ')
          ..write('showFpe: $showFpe, ')
          ..write('fpeFactor: $fpeFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeBasedInsulinFactorsTableTable extends TimeBasedInsulinFactorsTable
    with
        TableInfo<
          $TimeBasedInsulinFactorsTableTable,
          TimeBasedInsulinFactorsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeBasedInsulinFactorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userSettingsIdMeta = const VerificationMeta(
    'userSettingsId',
  );
  @override
  late final GeneratedColumn<String> userSettingsId = GeneratedColumn<String>(
    'user_settings_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMinutesMeta = const VerificationMeta(
    'startTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> startTimeMinutes = GeneratedColumn<int>(
    'start_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMinutesMeta = const VerificationMeta(
    'endTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> endTimeMinutes = GeneratedColumn<int>(
    'end_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _insulinFactorMeta = const VerificationMeta(
    'insulinFactor',
  );
  @override
  late final GeneratedColumn<double> insulinFactor = GeneratedColumn<double>(
    'insulin_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userSettingsId,
    startTimeMinutes,
    endTimeMinutes,
    insulinFactor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_based_insulin_factors_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeBasedInsulinFactorsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_settings_id')) {
      context.handle(
        _userSettingsIdMeta,
        userSettingsId.isAcceptableOrUnknown(
          data['user_settings_id']!,
          _userSettingsIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userSettingsIdMeta);
    }
    if (data.containsKey('start_time_minutes')) {
      context.handle(
        _startTimeMinutesMeta,
        startTimeMinutes.isAcceptableOrUnknown(
          data['start_time_minutes']!,
          _startTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startTimeMinutesMeta);
    }
    if (data.containsKey('end_time_minutes')) {
      context.handle(
        _endTimeMinutesMeta,
        endTimeMinutes.isAcceptableOrUnknown(
          data['end_time_minutes']!,
          _endTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endTimeMinutesMeta);
    }
    if (data.containsKey('insulin_factor')) {
      context.handle(
        _insulinFactorMeta,
        insulinFactor.isAcceptableOrUnknown(
          data['insulin_factor']!,
          _insulinFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_insulinFactorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeBasedInsulinFactorsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeBasedInsulinFactorsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      userSettingsId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_settings_id'],
          )!,
      startTimeMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}start_time_minutes'],
          )!,
      endTimeMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}end_time_minutes'],
          )!,
      insulinFactor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}insulin_factor'],
          )!,
    );
  }

  @override
  $TimeBasedInsulinFactorsTableTable createAlias(String alias) {
    return $TimeBasedInsulinFactorsTableTable(attachedDatabase, alias);
  }
}

class TimeBasedInsulinFactorsTableData extends DataClass
    implements Insertable<TimeBasedInsulinFactorsTableData> {
  final String id;
  final String userSettingsId;
  final int startTimeMinutes;
  final int endTimeMinutes;
  final double insulinFactor;
  const TimeBasedInsulinFactorsTableData({
    required this.id,
    required this.userSettingsId,
    required this.startTimeMinutes,
    required this.endTimeMinutes,
    required this.insulinFactor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_settings_id'] = Variable<String>(userSettingsId);
    map['start_time_minutes'] = Variable<int>(startTimeMinutes);
    map['end_time_minutes'] = Variable<int>(endTimeMinutes);
    map['insulin_factor'] = Variable<double>(insulinFactor);
    return map;
  }

  TimeBasedInsulinFactorsTableCompanion toCompanion(bool nullToAbsent) {
    return TimeBasedInsulinFactorsTableCompanion(
      id: Value(id),
      userSettingsId: Value(userSettingsId),
      startTimeMinutes: Value(startTimeMinutes),
      endTimeMinutes: Value(endTimeMinutes),
      insulinFactor: Value(insulinFactor),
    );
  }

  factory TimeBasedInsulinFactorsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeBasedInsulinFactorsTableData(
      id: serializer.fromJson<String>(json['id']),
      userSettingsId: serializer.fromJson<String>(json['userSettingsId']),
      startTimeMinutes: serializer.fromJson<int>(json['startTimeMinutes']),
      endTimeMinutes: serializer.fromJson<int>(json['endTimeMinutes']),
      insulinFactor: serializer.fromJson<double>(json['insulinFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userSettingsId': serializer.toJson<String>(userSettingsId),
      'startTimeMinutes': serializer.toJson<int>(startTimeMinutes),
      'endTimeMinutes': serializer.toJson<int>(endTimeMinutes),
      'insulinFactor': serializer.toJson<double>(insulinFactor),
    };
  }

  TimeBasedInsulinFactorsTableData copyWith({
    String? id,
    String? userSettingsId,
    int? startTimeMinutes,
    int? endTimeMinutes,
    double? insulinFactor,
  }) => TimeBasedInsulinFactorsTableData(
    id: id ?? this.id,
    userSettingsId: userSettingsId ?? this.userSettingsId,
    startTimeMinutes: startTimeMinutes ?? this.startTimeMinutes,
    endTimeMinutes: endTimeMinutes ?? this.endTimeMinutes,
    insulinFactor: insulinFactor ?? this.insulinFactor,
  );
  TimeBasedInsulinFactorsTableData copyWithCompanion(
    TimeBasedInsulinFactorsTableCompanion data,
  ) {
    return TimeBasedInsulinFactorsTableData(
      id: data.id.present ? data.id.value : this.id,
      userSettingsId:
          data.userSettingsId.present
              ? data.userSettingsId.value
              : this.userSettingsId,
      startTimeMinutes:
          data.startTimeMinutes.present
              ? data.startTimeMinutes.value
              : this.startTimeMinutes,
      endTimeMinutes:
          data.endTimeMinutes.present
              ? data.endTimeMinutes.value
              : this.endTimeMinutes,
      insulinFactor:
          data.insulinFactor.present
              ? data.insulinFactor.value
              : this.insulinFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeBasedInsulinFactorsTableData(')
          ..write('id: $id, ')
          ..write('userSettingsId: $userSettingsId, ')
          ..write('startTimeMinutes: $startTimeMinutes, ')
          ..write('endTimeMinutes: $endTimeMinutes, ')
          ..write('insulinFactor: $insulinFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userSettingsId,
    startTimeMinutes,
    endTimeMinutes,
    insulinFactor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeBasedInsulinFactorsTableData &&
          other.id == this.id &&
          other.userSettingsId == this.userSettingsId &&
          other.startTimeMinutes == this.startTimeMinutes &&
          other.endTimeMinutes == this.endTimeMinutes &&
          other.insulinFactor == this.insulinFactor);
}

class TimeBasedInsulinFactorsTableCompanion
    extends UpdateCompanion<TimeBasedInsulinFactorsTableData> {
  final Value<String> id;
  final Value<String> userSettingsId;
  final Value<int> startTimeMinutes;
  final Value<int> endTimeMinutes;
  final Value<double> insulinFactor;
  final Value<int> rowid;
  const TimeBasedInsulinFactorsTableCompanion({
    this.id = const Value.absent(),
    this.userSettingsId = const Value.absent(),
    this.startTimeMinutes = const Value.absent(),
    this.endTimeMinutes = const Value.absent(),
    this.insulinFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeBasedInsulinFactorsTableCompanion.insert({
    required String id,
    required String userSettingsId,
    required int startTimeMinutes,
    required int endTimeMinutes,
    required double insulinFactor,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userSettingsId = Value(userSettingsId),
       startTimeMinutes = Value(startTimeMinutes),
       endTimeMinutes = Value(endTimeMinutes),
       insulinFactor = Value(insulinFactor);
  static Insertable<TimeBasedInsulinFactorsTableData> custom({
    Expression<String>? id,
    Expression<String>? userSettingsId,
    Expression<int>? startTimeMinutes,
    Expression<int>? endTimeMinutes,
    Expression<double>? insulinFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userSettingsId != null) 'user_settings_id': userSettingsId,
      if (startTimeMinutes != null) 'start_time_minutes': startTimeMinutes,
      if (endTimeMinutes != null) 'end_time_minutes': endTimeMinutes,
      if (insulinFactor != null) 'insulin_factor': insulinFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeBasedInsulinFactorsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userSettingsId,
    Value<int>? startTimeMinutes,
    Value<int>? endTimeMinutes,
    Value<double>? insulinFactor,
    Value<int>? rowid,
  }) {
    return TimeBasedInsulinFactorsTableCompanion(
      id: id ?? this.id,
      userSettingsId: userSettingsId ?? this.userSettingsId,
      startTimeMinutes: startTimeMinutes ?? this.startTimeMinutes,
      endTimeMinutes: endTimeMinutes ?? this.endTimeMinutes,
      insulinFactor: insulinFactor ?? this.insulinFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userSettingsId.present) {
      map['user_settings_id'] = Variable<String>(userSettingsId.value);
    }
    if (startTimeMinutes.present) {
      map['start_time_minutes'] = Variable<int>(startTimeMinutes.value);
    }
    if (endTimeMinutes.present) {
      map['end_time_minutes'] = Variable<int>(endTimeMinutes.value);
    }
    if (insulinFactor.present) {
      map['insulin_factor'] = Variable<double>(insulinFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeBasedInsulinFactorsTableCompanion(')
          ..write('id: $id, ')
          ..write('userSettingsId: $userSettingsId, ')
          ..write('startTimeMinutes: $startTimeMinutes, ')
          ..write('endTimeMinutes: $endTimeMinutes, ')
          ..write('insulinFactor: $insulinFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NutritionsTableTable nutritionsTable = $NutritionsTableTable(
    this,
  );
  late final $MealsTableTable mealsTable = $MealsTableTable(this);
  late final $UserSettingsTableTable userSettingsTable =
      $UserSettingsTableTable(this);
  late final $TimeBasedInsulinFactorsTableTable timeBasedInsulinFactorsTable =
      $TimeBasedInsulinFactorsTableTable(this);
  late final MealDao mealDao = MealDao(this as AppDatabase);
  late final UserSettingsDao userSettingsDao = UserSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    nutritionsTable,
    mealsTable,
    userSettingsTable,
    timeBasedInsulinFactorsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'nutritions_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meals_table', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$NutritionsTableTableCreateCompanionBuilder =
    NutritionsTableCompanion Function({
      required String id,
      Value<double?> carbs,
      Value<double?> sugar,
      Value<double?> fat,
      Value<double?> saturatedFat,
      Value<double?> protein,
      Value<double?> weightOnePiece,
      Value<int> rowid,
    });
typedef $$NutritionsTableTableUpdateCompanionBuilder =
    NutritionsTableCompanion Function({
      Value<String> id,
      Value<double?> carbs,
      Value<double?> sugar,
      Value<double?> fat,
      Value<double?> saturatedFat,
      Value<double?> protein,
      Value<double?> weightOnePiece,
      Value<int> rowid,
    });

final class $$NutritionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NutritionsTableTable,
          NutritionsTableData
        > {
  $$NutritionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MealsTableTable, List<MealsTableData>>
  _mealsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealsTable,
    aliasName: $_aliasNameGenerator(
      db.nutritionsTable.id,
      db.mealsTable.nutritionId,
    ),
  );

  $$MealsTableTableProcessedTableManager get mealsTableRefs {
    final manager = $$MealsTableTableTableManager(
      $_db,
      $_db.mealsTable,
    ).filter((f) => f.nutritionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NutritionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionsTableTable> {
  $$NutritionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sugar => $composableBuilder(
    column: $table.sugar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightOnePiece => $composableBuilder(
    column: $table.weightOnePiece,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealsTableRefs(
    Expression<bool> Function($$MealsTableTableFilterComposer f) f,
  ) {
    final $$MealsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealsTable,
      getReferencedColumn: (t) => t.nutritionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableTableFilterComposer(
            $db: $db,
            $table: $db.mealsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionsTableTable> {
  $$NutritionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sugar => $composableBuilder(
    column: $table.sugar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightOnePiece => $composableBuilder(
    column: $table.weightOnePiece,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionsTableTable> {
  $$NutritionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get sugar =>
      $composableBuilder(column: $table.sugar, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get weightOnePiece => $composableBuilder(
    column: $table.weightOnePiece,
    builder: (column) => column,
  );

  Expression<T> mealsTableRefs<T extends Object>(
    Expression<T> Function($$MealsTableTableAnnotationComposer a) f,
  ) {
    final $$MealsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealsTable,
      getReferencedColumn: (t) => t.nutritionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionsTableTable,
          NutritionsTableData,
          $$NutritionsTableTableFilterComposer,
          $$NutritionsTableTableOrderingComposer,
          $$NutritionsTableTableAnnotationComposer,
          $$NutritionsTableTableCreateCompanionBuilder,
          $$NutritionsTableTableUpdateCompanionBuilder,
          (NutritionsTableData, $$NutritionsTableTableReferences),
          NutritionsTableData,
          PrefetchHooks Function({bool mealsTableRefs})
        > {
  $$NutritionsTableTableTableManager(
    _$AppDatabase db,
    $NutritionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$NutritionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NutritionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$NutritionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<double?> sugar = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> saturatedFat = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> weightOnePiece = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NutritionsTableCompanion(
                id: id,
                carbs: carbs,
                sugar: sugar,
                fat: fat,
                saturatedFat: saturatedFat,
                protein: protein,
                weightOnePiece: weightOnePiece,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<double?> carbs = const Value.absent(),
                Value<double?> sugar = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> saturatedFat = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> weightOnePiece = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NutritionsTableCompanion.insert(
                id: id,
                carbs: carbs,
                sugar: sugar,
                fat: fat,
                saturatedFat: saturatedFat,
                protein: protein,
                weightOnePiece: weightOnePiece,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$NutritionsTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({mealsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mealsTableRefs) db.mealsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealsTableRefs)
                    await $_getPrefetchedData<
                      NutritionsTableData,
                      $NutritionsTableTable,
                      MealsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$NutritionsTableTableReferences
                          ._mealsTableRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$NutritionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).mealsTableRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.nutritionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NutritionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionsTableTable,
      NutritionsTableData,
      $$NutritionsTableTableFilterComposer,
      $$NutritionsTableTableOrderingComposer,
      $$NutritionsTableTableAnnotationComposer,
      $$NutritionsTableTableCreateCompanionBuilder,
      $$NutritionsTableTableUpdateCompanionBuilder,
      (NutritionsTableData, $$NutritionsTableTableReferences),
      NutritionsTableData,
      PrefetchHooks Function({bool mealsTableRefs})
    >;
typedef $$MealsTableTableCreateCompanionBuilder =
    MealsTableCompanion Function({
      required String id,
      required String carbUnit,
      required String name,
      Value<String?> imagePath,
      required DateTime timestamp,
      Value<double?> carbsInUnit,
      Value<double?> fpe,
      Value<String?> nutritionId,
      Value<String?> location,
      Value<double?> portionsize,
      Value<String?> portionUnit,
      Value<String?> note,
      Value<String?> categories,
      Value<int> rowid,
    });
typedef $$MealsTableTableUpdateCompanionBuilder =
    MealsTableCompanion Function({
      Value<String> id,
      Value<String> carbUnit,
      Value<String> name,
      Value<String?> imagePath,
      Value<DateTime> timestamp,
      Value<double?> carbsInUnit,
      Value<double?> fpe,
      Value<String?> nutritionId,
      Value<String?> location,
      Value<double?> portionsize,
      Value<String?> portionUnit,
      Value<String?> note,
      Value<String?> categories,
      Value<int> rowid,
    });

final class $$MealsTableTableReferences
    extends BaseReferences<_$AppDatabase, $MealsTableTable, MealsTableData> {
  $$MealsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NutritionsTableTable _nutritionIdTable(_$AppDatabase db) =>
      db.nutritionsTable.createAlias(
        $_aliasNameGenerator(db.mealsTable.nutritionId, db.nutritionsTable.id),
      );

  $$NutritionsTableTableProcessedTableManager? get nutritionId {
    final $_column = $_itemColumn<String>('nutrition_id');
    if ($_column == null) return null;
    final manager = $$NutritionsTableTableTableManager(
      $_db,
      $_db.nutritionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_nutritionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MealsTableTable> {
  $$MealsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carbUnit => $composableBuilder(
    column: $table.carbUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsInUnit => $composableBuilder(
    column: $table.carbsInUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fpe => $composableBuilder(
    column: $table.fpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get portionsize => $composableBuilder(
    column: $table.portionsize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portionUnit => $composableBuilder(
    column: $table.portionUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnFilters(column),
  );

  $$NutritionsTableTableFilterComposer get nutritionId {
    final $$NutritionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutritionId,
      referencedTable: $db.nutritionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionsTableTableFilterComposer(
            $db: $db,
            $table: $db.nutritionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTableTable> {
  $$MealsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carbUnit => $composableBuilder(
    column: $table.carbUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsInUnit => $composableBuilder(
    column: $table.carbsInUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fpe => $composableBuilder(
    column: $table.fpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get portionsize => $composableBuilder(
    column: $table.portionsize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portionUnit => $composableBuilder(
    column: $table.portionUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => ColumnOrderings(column),
  );

  $$NutritionsTableTableOrderingComposer get nutritionId {
    final $$NutritionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutritionId,
      referencedTable: $db.nutritionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.nutritionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTableTable> {
  $$MealsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get carbUnit =>
      $composableBuilder(column: $table.carbUnit, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get carbsInUnit => $composableBuilder(
    column: $table.carbsInUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fpe =>
      $composableBuilder(column: $table.fpe, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<double> get portionsize => $composableBuilder(
    column: $table.portionsize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get portionUnit => $composableBuilder(
    column: $table.portionUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => column,
  );

  $$NutritionsTableTableAnnotationComposer get nutritionId {
    final $$NutritionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.nutritionId,
      referencedTable: $db.nutritionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.nutritionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTableTable,
          MealsTableData,
          $$MealsTableTableFilterComposer,
          $$MealsTableTableOrderingComposer,
          $$MealsTableTableAnnotationComposer,
          $$MealsTableTableCreateCompanionBuilder,
          $$MealsTableTableUpdateCompanionBuilder,
          (MealsTableData, $$MealsTableTableReferences),
          MealsTableData,
          PrefetchHooks Function({bool nutritionId})
        > {
  $$MealsTableTableTableManager(_$AppDatabase db, $MealsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MealsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MealsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MealsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> carbUnit = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> carbsInUnit = const Value.absent(),
                Value<double?> fpe = const Value.absent(),
                Value<String?> nutritionId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> portionsize = const Value.absent(),
                Value<String?> portionUnit = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsTableCompanion(
                id: id,
                carbUnit: carbUnit,
                name: name,
                imagePath: imagePath,
                timestamp: timestamp,
                carbsInUnit: carbsInUnit,
                fpe: fpe,
                nutritionId: nutritionId,
                location: location,
                portionsize: portionsize,
                portionUnit: portionUnit,
                note: note,
                categories: categories,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String carbUnit,
                required String name,
                Value<String?> imagePath = const Value.absent(),
                required DateTime timestamp,
                Value<double?> carbsInUnit = const Value.absent(),
                Value<double?> fpe = const Value.absent(),
                Value<String?> nutritionId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> portionsize = const Value.absent(),
                Value<String?> portionUnit = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsTableCompanion.insert(
                id: id,
                carbUnit: carbUnit,
                name: name,
                imagePath: imagePath,
                timestamp: timestamp,
                carbsInUnit: carbsInUnit,
                fpe: fpe,
                nutritionId: nutritionId,
                location: location,
                portionsize: portionsize,
                portionUnit: portionUnit,
                note: note,
                categories: categories,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$MealsTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({nutritionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (nutritionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.nutritionId,
                            referencedTable: $$MealsTableTableReferences
                                ._nutritionIdTable(db),
                            referencedColumn:
                                $$MealsTableTableReferences
                                    ._nutritionIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTableTable,
      MealsTableData,
      $$MealsTableTableFilterComposer,
      $$MealsTableTableOrderingComposer,
      $$MealsTableTableAnnotationComposer,
      $$MealsTableTableCreateCompanionBuilder,
      $$MealsTableTableUpdateCompanionBuilder,
      (MealsTableData, $$MealsTableTableReferences),
      MealsTableData,
      PrefetchHooks Function({bool nutritionId})
    >;
typedef $$UserSettingsTableTableCreateCompanionBuilder =
    UserSettingsTableCompanion Function({
      Value<String> id,
      required CarbUnit carbUnit,
      Value<bool> showFpe,
      Value<double?> fpeFactor,
      Value<int> rowid,
    });
typedef $$UserSettingsTableTableUpdateCompanionBuilder =
    UserSettingsTableCompanion Function({
      Value<String> id,
      Value<CarbUnit> carbUnit,
      Value<bool> showFpe,
      Value<double?> fpeFactor,
      Value<int> rowid,
    });

class $$UserSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CarbUnit, CarbUnit, String> get carbUnit =>
      $composableBuilder(
        column: $table.carbUnit,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get showFpe => $composableBuilder(
    column: $table.showFpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fpeFactor => $composableBuilder(
    column: $table.fpeFactor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carbUnit => $composableBuilder(
    column: $table.carbUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showFpe => $composableBuilder(
    column: $table.showFpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fpeFactor => $composableBuilder(
    column: $table.fpeFactor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CarbUnit, String> get carbUnit =>
      $composableBuilder(column: $table.carbUnit, builder: (column) => column);

  GeneratedColumn<bool> get showFpe =>
      $composableBuilder(column: $table.showFpe, builder: (column) => column);

  GeneratedColumn<double> get fpeFactor =>
      $composableBuilder(column: $table.fpeFactor, builder: (column) => column);
}

class $$UserSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTableTable,
          UserSettingsTableData,
          $$UserSettingsTableTableFilterComposer,
          $$UserSettingsTableTableOrderingComposer,
          $$UserSettingsTableTableAnnotationComposer,
          $$UserSettingsTableTableCreateCompanionBuilder,
          $$UserSettingsTableTableUpdateCompanionBuilder,
          (
            UserSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $UserSettingsTableTable,
              UserSettingsTableData
            >,
          ),
          UserSettingsTableData,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableTableManager(
    _$AppDatabase db,
    $UserSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserSettingsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$UserSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$UserSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<CarbUnit> carbUnit = const Value.absent(),
                Value<bool> showFpe = const Value.absent(),
                Value<double?> fpeFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsTableCompanion(
                id: id,
                carbUnit: carbUnit,
                showFpe: showFpe,
                fpeFactor: fpeFactor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required CarbUnit carbUnit,
                Value<bool> showFpe = const Value.absent(),
                Value<double?> fpeFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsTableCompanion.insert(
                id: id,
                carbUnit: carbUnit,
                showFpe: showFpe,
                fpeFactor: fpeFactor,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTableTable,
      UserSettingsTableData,
      $$UserSettingsTableTableFilterComposer,
      $$UserSettingsTableTableOrderingComposer,
      $$UserSettingsTableTableAnnotationComposer,
      $$UserSettingsTableTableCreateCompanionBuilder,
      $$UserSettingsTableTableUpdateCompanionBuilder,
      (
        UserSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $UserSettingsTableTable,
          UserSettingsTableData
        >,
      ),
      UserSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$TimeBasedInsulinFactorsTableTableCreateCompanionBuilder =
    TimeBasedInsulinFactorsTableCompanion Function({
      required String id,
      required String userSettingsId,
      required int startTimeMinutes,
      required int endTimeMinutes,
      required double insulinFactor,
      Value<int> rowid,
    });
typedef $$TimeBasedInsulinFactorsTableTableUpdateCompanionBuilder =
    TimeBasedInsulinFactorsTableCompanion Function({
      Value<String> id,
      Value<String> userSettingsId,
      Value<int> startTimeMinutes,
      Value<int> endTimeMinutes,
      Value<double> insulinFactor,
      Value<int> rowid,
    });

class $$TimeBasedInsulinFactorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TimeBasedInsulinFactorsTableTable> {
  $$TimeBasedInsulinFactorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userSettingsId => $composableBuilder(
    column: $table.userSettingsId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTimeMinutes => $composableBuilder(
    column: $table.startTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endTimeMinutes => $composableBuilder(
    column: $table.endTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get insulinFactor => $composableBuilder(
    column: $table.insulinFactor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeBasedInsulinFactorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeBasedInsulinFactorsTableTable> {
  $$TimeBasedInsulinFactorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userSettingsId => $composableBuilder(
    column: $table.userSettingsId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTimeMinutes => $composableBuilder(
    column: $table.startTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endTimeMinutes => $composableBuilder(
    column: $table.endTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get insulinFactor => $composableBuilder(
    column: $table.insulinFactor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeBasedInsulinFactorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeBasedInsulinFactorsTableTable> {
  $$TimeBasedInsulinFactorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userSettingsId => $composableBuilder(
    column: $table.userSettingsId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startTimeMinutes => $composableBuilder(
    column: $table.startTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endTimeMinutes => $composableBuilder(
    column: $table.endTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get insulinFactor => $composableBuilder(
    column: $table.insulinFactor,
    builder: (column) => column,
  );
}

class $$TimeBasedInsulinFactorsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeBasedInsulinFactorsTableTable,
          TimeBasedInsulinFactorsTableData,
          $$TimeBasedInsulinFactorsTableTableFilterComposer,
          $$TimeBasedInsulinFactorsTableTableOrderingComposer,
          $$TimeBasedInsulinFactorsTableTableAnnotationComposer,
          $$TimeBasedInsulinFactorsTableTableCreateCompanionBuilder,
          $$TimeBasedInsulinFactorsTableTableUpdateCompanionBuilder,
          (
            TimeBasedInsulinFactorsTableData,
            BaseReferences<
              _$AppDatabase,
              $TimeBasedInsulinFactorsTableTable,
              TimeBasedInsulinFactorsTableData
            >,
          ),
          TimeBasedInsulinFactorsTableData,
          PrefetchHooks Function()
        > {
  $$TimeBasedInsulinFactorsTableTableTableManager(
    _$AppDatabase db,
    $TimeBasedInsulinFactorsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TimeBasedInsulinFactorsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$TimeBasedInsulinFactorsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TimeBasedInsulinFactorsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userSettingsId = const Value.absent(),
                Value<int> startTimeMinutes = const Value.absent(),
                Value<int> endTimeMinutes = const Value.absent(),
                Value<double> insulinFactor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeBasedInsulinFactorsTableCompanion(
                id: id,
                userSettingsId: userSettingsId,
                startTimeMinutes: startTimeMinutes,
                endTimeMinutes: endTimeMinutes,
                insulinFactor: insulinFactor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userSettingsId,
                required int startTimeMinutes,
                required int endTimeMinutes,
                required double insulinFactor,
                Value<int> rowid = const Value.absent(),
              }) => TimeBasedInsulinFactorsTableCompanion.insert(
                id: id,
                userSettingsId: userSettingsId,
                startTimeMinutes: startTimeMinutes,
                endTimeMinutes: endTimeMinutes,
                insulinFactor: insulinFactor,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeBasedInsulinFactorsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeBasedInsulinFactorsTableTable,
      TimeBasedInsulinFactorsTableData,
      $$TimeBasedInsulinFactorsTableTableFilterComposer,
      $$TimeBasedInsulinFactorsTableTableOrderingComposer,
      $$TimeBasedInsulinFactorsTableTableAnnotationComposer,
      $$TimeBasedInsulinFactorsTableTableCreateCompanionBuilder,
      $$TimeBasedInsulinFactorsTableTableUpdateCompanionBuilder,
      (
        TimeBasedInsulinFactorsTableData,
        BaseReferences<
          _$AppDatabase,
          $TimeBasedInsulinFactorsTableTable,
          TimeBasedInsulinFactorsTableData
        >,
      ),
      TimeBasedInsulinFactorsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NutritionsTableTableTableManager get nutritionsTable =>
      $$NutritionsTableTableTableManager(_db, _db.nutritionsTable);
  $$MealsTableTableTableManager get mealsTable =>
      $$MealsTableTableTableManager(_db, _db.mealsTable);
  $$UserSettingsTableTableTableManager get userSettingsTable =>
      $$UserSettingsTableTableTableManager(_db, _db.userSettingsTable);
  $$TimeBasedInsulinFactorsTableTableTableManager
  get timeBasedInsulinFactorsTable =>
      $$TimeBasedInsulinFactorsTableTableTableManager(
        _db,
        _db.timeBasedInsulinFactorsTable,
      );
}
