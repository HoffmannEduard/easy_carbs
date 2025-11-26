// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
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
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    name,
    carbs,
    imagePath,
    timestamp,
    fat,
    protein,
    location,
    quantity,
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMeta);
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
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
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
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      carbs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}carbs'],
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
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      ),
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
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
  final String name;
  final double carbs;
  final String? imagePath;
  final DateTime timestamp;
  final double? fat;
  final double? protein;
  final String? location;
  final double? quantity;
  final String? note;
  final String? categories;
  const MealsTableData({
    required this.id,
    required this.name,
    required this.carbs,
    this.imagePath,
    required this.timestamp,
    this.fat,
    this.protein,
    this.location,
    this.quantity,
    this.note,
    this.categories,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['carbs'] = Variable<double>(carbs);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
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
      name: Value(name),
      carbs: Value(carbs),
      imagePath:
          imagePath == null && nullToAbsent
              ? const Value.absent()
              : Value(imagePath),
      timestamp: Value(timestamp),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      protein:
          protein == null && nullToAbsent
              ? const Value.absent()
              : Value(protein),
      location:
          location == null && nullToAbsent
              ? const Value.absent()
              : Value(location),
      quantity:
          quantity == null && nullToAbsent
              ? const Value.absent()
              : Value(quantity),
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
      name: serializer.fromJson<String>(json['name']),
      carbs: serializer.fromJson<double>(json['carbs']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      fat: serializer.fromJson<double?>(json['fat']),
      protein: serializer.fromJson<double?>(json['protein']),
      location: serializer.fromJson<String?>(json['location']),
      quantity: serializer.fromJson<double?>(json['quantity']),
      note: serializer.fromJson<String?>(json['note']),
      categories: serializer.fromJson<String?>(json['categories']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'carbs': serializer.toJson<double>(carbs),
      'imagePath': serializer.toJson<String?>(imagePath),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'fat': serializer.toJson<double?>(fat),
      'protein': serializer.toJson<double?>(protein),
      'location': serializer.toJson<String?>(location),
      'quantity': serializer.toJson<double?>(quantity),
      'note': serializer.toJson<String?>(note),
      'categories': serializer.toJson<String?>(categories),
    };
  }

  MealsTableData copyWith({
    String? id,
    String? name,
    double? carbs,
    Value<String?> imagePath = const Value.absent(),
    DateTime? timestamp,
    Value<double?> fat = const Value.absent(),
    Value<double?> protein = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<double?> quantity = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> categories = const Value.absent(),
  }) => MealsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    carbs: carbs ?? this.carbs,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    timestamp: timestamp ?? this.timestamp,
    fat: fat.present ? fat.value : this.fat,
    protein: protein.present ? protein.value : this.protein,
    location: location.present ? location.value : this.location,
    quantity: quantity.present ? quantity.value : this.quantity,
    note: note.present ? note.value : this.note,
    categories: categories.present ? categories.value : this.categories,
  );
  MealsTableData copyWithCompanion(MealsTableCompanion data) {
    return MealsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      fat: data.fat.present ? data.fat.value : this.fat,
      protein: data.protein.present ? data.protein.value : this.protein,
      location: data.location.present ? data.location.value : this.location,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      note: data.note.present ? data.note.value : this.note,
      categories:
          data.categories.present ? data.categories.value : this.categories,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('carbs: $carbs, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('fat: $fat, ')
          ..write('protein: $protein, ')
          ..write('location: $location, ')
          ..write('quantity: $quantity, ')
          ..write('note: $note, ')
          ..write('categories: $categories')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    carbs,
    imagePath,
    timestamp,
    fat,
    protein,
    location,
    quantity,
    note,
    categories,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.carbs == this.carbs &&
          other.imagePath == this.imagePath &&
          other.timestamp == this.timestamp &&
          other.fat == this.fat &&
          other.protein == this.protein &&
          other.location == this.location &&
          other.quantity == this.quantity &&
          other.note == this.note &&
          other.categories == this.categories);
}

class MealsTableCompanion extends UpdateCompanion<MealsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> carbs;
  final Value<String?> imagePath;
  final Value<DateTime> timestamp;
  final Value<double?> fat;
  final Value<double?> protein;
  final Value<String?> location;
  final Value<double?> quantity;
  final Value<String?> note;
  final Value<String?> categories;
  final Value<int> rowid;
  const MealsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.carbs = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.fat = const Value.absent(),
    this.protein = const Value.absent(),
    this.location = const Value.absent(),
    this.quantity = const Value.absent(),
    this.note = const Value.absent(),
    this.categories = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsTableCompanion.insert({
    required String id,
    required String name,
    required double carbs,
    this.imagePath = const Value.absent(),
    required DateTime timestamp,
    this.fat = const Value.absent(),
    this.protein = const Value.absent(),
    this.location = const Value.absent(),
    this.quantity = const Value.absent(),
    this.note = const Value.absent(),
    this.categories = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       carbs = Value(carbs),
       timestamp = Value(timestamp);
  static Insertable<MealsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? carbs,
    Expression<String>? imagePath,
    Expression<DateTime>? timestamp,
    Expression<double>? fat,
    Expression<double>? protein,
    Expression<String>? location,
    Expression<double>? quantity,
    Expression<String>? note,
    Expression<String>? categories,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (carbs != null) 'carbs': carbs,
      if (imagePath != null) 'image_path': imagePath,
      if (timestamp != null) 'timestamp': timestamp,
      if (fat != null) 'fat': fat,
      if (protein != null) 'protein': protein,
      if (location != null) 'location': location,
      if (quantity != null) 'quantity': quantity,
      if (note != null) 'note': note,
      if (categories != null) 'categories': categories,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? carbs,
    Value<String?>? imagePath,
    Value<DateTime>? timestamp,
    Value<double?>? fat,
    Value<double?>? protein,
    Value<String?>? location,
    Value<double?>? quantity,
    Value<String?>? note,
    Value<String?>? categories,
    Value<int>? rowid,
  }) {
    return MealsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      carbs: carbs ?? this.carbs,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
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
          ..write('name: $name, ')
          ..write('carbs: $carbs, ')
          ..write('imagePath: $imagePath, ')
          ..write('timestamp: $timestamp, ')
          ..write('fat: $fat, ')
          ..write('protein: $protein, ')
          ..write('location: $location, ')
          ..write('quantity: $quantity, ')
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
    requiredDuringInsert: true,
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
  static const VerificationMeta _carbFactorMeta = const VerificationMeta(
    'carbFactor',
  );
  @override
  late final GeneratedColumn<double> carbFactor = GeneratedColumn<double>(
    'carb_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _darkModeMeta = const VerificationMeta(
    'darkMode',
  );
  @override
  late final GeneratedColumn<bool> darkMode = GeneratedColumn<bool>(
    'dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dark_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carbUnit,
    carbFactor,
    showFpe,
    fpeFactor,
    darkMode,
  ];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('carb_factor')) {
      context.handle(
        _carbFactorMeta,
        carbFactor.isAcceptableOrUnknown(data['carb_factor']!, _carbFactorMeta),
      );
    } else if (isInserting) {
      context.missing(_carbFactorMeta);
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
    if (data.containsKey('dark_mode')) {
      context.handle(
        _darkModeMeta,
        darkMode.isAcceptableOrUnknown(data['dark_mode']!, _darkModeMeta),
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
      carbFactor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}carb_factor'],
          )!,
      showFpe:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}show_fpe'],
          )!,
      fpeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fpe_factor'],
      ),
      darkMode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}dark_mode'],
          )!,
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
  final double carbFactor;
  final bool showFpe;
  final double? fpeFactor;
  final bool darkMode;
  const UserSettingsTableData({
    required this.id,
    required this.carbUnit,
    required this.carbFactor,
    required this.showFpe,
    this.fpeFactor,
    required this.darkMode,
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
    map['carb_factor'] = Variable<double>(carbFactor);
    map['show_fpe'] = Variable<bool>(showFpe);
    if (!nullToAbsent || fpeFactor != null) {
      map['fpe_factor'] = Variable<double>(fpeFactor);
    }
    map['dark_mode'] = Variable<bool>(darkMode);
    return map;
  }

  UserSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsTableCompanion(
      id: Value(id),
      carbUnit: Value(carbUnit),
      carbFactor: Value(carbFactor),
      showFpe: Value(showFpe),
      fpeFactor:
          fpeFactor == null && nullToAbsent
              ? const Value.absent()
              : Value(fpeFactor),
      darkMode: Value(darkMode),
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
      carbFactor: serializer.fromJson<double>(json['carbFactor']),
      showFpe: serializer.fromJson<bool>(json['showFpe']),
      fpeFactor: serializer.fromJson<double?>(json['fpeFactor']),
      darkMode: serializer.fromJson<bool>(json['darkMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'carbUnit': serializer.toJson<CarbUnit>(carbUnit),
      'carbFactor': serializer.toJson<double>(carbFactor),
      'showFpe': serializer.toJson<bool>(showFpe),
      'fpeFactor': serializer.toJson<double?>(fpeFactor),
      'darkMode': serializer.toJson<bool>(darkMode),
    };
  }

  UserSettingsTableData copyWith({
    String? id,
    CarbUnit? carbUnit,
    double? carbFactor,
    bool? showFpe,
    Value<double?> fpeFactor = const Value.absent(),
    bool? darkMode,
  }) => UserSettingsTableData(
    id: id ?? this.id,
    carbUnit: carbUnit ?? this.carbUnit,
    carbFactor: carbFactor ?? this.carbFactor,
    showFpe: showFpe ?? this.showFpe,
    fpeFactor: fpeFactor.present ? fpeFactor.value : this.fpeFactor,
    darkMode: darkMode ?? this.darkMode,
  );
  UserSettingsTableData copyWithCompanion(UserSettingsTableCompanion data) {
    return UserSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      carbUnit: data.carbUnit.present ? data.carbUnit.value : this.carbUnit,
      carbFactor:
          data.carbFactor.present ? data.carbFactor.value : this.carbFactor,
      showFpe: data.showFpe.present ? data.showFpe.value : this.showFpe,
      fpeFactor: data.fpeFactor.present ? data.fpeFactor.value : this.fpeFactor,
      darkMode: data.darkMode.present ? data.darkMode.value : this.darkMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsTableData(')
          ..write('id: $id, ')
          ..write('carbUnit: $carbUnit, ')
          ..write('carbFactor: $carbFactor, ')
          ..write('showFpe: $showFpe, ')
          ..write('fpeFactor: $fpeFactor, ')
          ..write('darkMode: $darkMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, carbUnit, carbFactor, showFpe, fpeFactor, darkMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsTableData &&
          other.id == this.id &&
          other.carbUnit == this.carbUnit &&
          other.carbFactor == this.carbFactor &&
          other.showFpe == this.showFpe &&
          other.fpeFactor == this.fpeFactor &&
          other.darkMode == this.darkMode);
}

class UserSettingsTableCompanion
    extends UpdateCompanion<UserSettingsTableData> {
  final Value<String> id;
  final Value<CarbUnit> carbUnit;
  final Value<double> carbFactor;
  final Value<bool> showFpe;
  final Value<double?> fpeFactor;
  final Value<bool> darkMode;
  final Value<int> rowid;
  const UserSettingsTableCompanion({
    this.id = const Value.absent(),
    this.carbUnit = const Value.absent(),
    this.carbFactor = const Value.absent(),
    this.showFpe = const Value.absent(),
    this.fpeFactor = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsTableCompanion.insert({
    required String id,
    required CarbUnit carbUnit,
    required double carbFactor,
    this.showFpe = const Value.absent(),
    this.fpeFactor = const Value.absent(),
    this.darkMode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       carbUnit = Value(carbUnit),
       carbFactor = Value(carbFactor);
  static Insertable<UserSettingsTableData> custom({
    Expression<String>? id,
    Expression<String>? carbUnit,
    Expression<double>? carbFactor,
    Expression<bool>? showFpe,
    Expression<double>? fpeFactor,
    Expression<bool>? darkMode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carbUnit != null) 'carb_unit': carbUnit,
      if (carbFactor != null) 'carb_factor': carbFactor,
      if (showFpe != null) 'show_fpe': showFpe,
      if (fpeFactor != null) 'fpe_factor': fpeFactor,
      if (darkMode != null) 'dark_mode': darkMode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<CarbUnit>? carbUnit,
    Value<double>? carbFactor,
    Value<bool>? showFpe,
    Value<double?>? fpeFactor,
    Value<bool>? darkMode,
    Value<int>? rowid,
  }) {
    return UserSettingsTableCompanion(
      id: id ?? this.id,
      carbUnit: carbUnit ?? this.carbUnit,
      carbFactor: carbFactor ?? this.carbFactor,
      showFpe: showFpe ?? this.showFpe,
      fpeFactor: fpeFactor ?? this.fpeFactor,
      darkMode: darkMode ?? this.darkMode,
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
    if (carbFactor.present) {
      map['carb_factor'] = Variable<double>(carbFactor.value);
    }
    if (showFpe.present) {
      map['show_fpe'] = Variable<bool>(showFpe.value);
    }
    if (fpeFactor.present) {
      map['fpe_factor'] = Variable<double>(fpeFactor.value);
    }
    if (darkMode.present) {
      map['dark_mode'] = Variable<bool>(darkMode.value);
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
          ..write('carbFactor: $carbFactor, ')
          ..write('showFpe: $showFpe, ')
          ..write('fpeFactor: $fpeFactor, ')
          ..write('darkMode: $darkMode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealsTableTable mealsTable = $MealsTableTable(this);
  late final $UserSettingsTableTable userSettingsTable =
      $UserSettingsTableTable(this);
  late final MealDao mealDao = MealDao(this as AppDatabase);
  late final UserSettingsDao userSettingsDao = UserSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mealsTable,
    userSettingsTable,
  ];
}

typedef $$MealsTableTableCreateCompanionBuilder =
    MealsTableCompanion Function({
      required String id,
      required String name,
      required double carbs,
      Value<String?> imagePath,
      required DateTime timestamp,
      Value<double?> fat,
      Value<double?> protein,
      Value<String?> location,
      Value<double?> quantity,
      Value<String?> note,
      Value<String?> categories,
      Value<int> rowid,
    });
typedef $$MealsTableTableUpdateCompanionBuilder =
    MealsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> carbs,
      Value<String?> imagePath,
      Value<DateTime> timestamp,
      Value<double?> fat,
      Value<double?> protein,
      Value<String?> location,
      Value<double?> quantity,
      Value<String?> note,
      Value<String?> categories,
      Value<int> rowid,
    });

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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
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

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
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

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get categories => $composableBuilder(
    column: $table.categories,
    builder: (column) => column,
  );
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
          (
            MealsTableData,
            BaseReferences<_$AppDatabase, $MealsTableTable, MealsTableData>,
          ),
          MealsTableData,
          PrefetchHooks Function()
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
                Value<String> name = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsTableCompanion(
                id: id,
                name: name,
                carbs: carbs,
                imagePath: imagePath,
                timestamp: timestamp,
                fat: fat,
                protein: protein,
                location: location,
                quantity: quantity,
                note: note,
                categories: categories,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double carbs,
                Value<String?> imagePath = const Value.absent(),
                required DateTime timestamp,
                Value<double?> fat = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> categories = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsTableCompanion.insert(
                id: id,
                name: name,
                carbs: carbs,
                imagePath: imagePath,
                timestamp: timestamp,
                fat: fat,
                protein: protein,
                location: location,
                quantity: quantity,
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
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
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
      (
        MealsTableData,
        BaseReferences<_$AppDatabase, $MealsTableTable, MealsTableData>,
      ),
      MealsTableData,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableTableCreateCompanionBuilder =
    UserSettingsTableCompanion Function({
      required String id,
      required CarbUnit carbUnit,
      required double carbFactor,
      Value<bool> showFpe,
      Value<double?> fpeFactor,
      Value<bool> darkMode,
      Value<int> rowid,
    });
typedef $$UserSettingsTableTableUpdateCompanionBuilder =
    UserSettingsTableCompanion Function({
      Value<String> id,
      Value<CarbUnit> carbUnit,
      Value<double> carbFactor,
      Value<bool> showFpe,
      Value<double?> fpeFactor,
      Value<bool> darkMode,
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

  ColumnFilters<double> get carbFactor => $composableBuilder(
    column: $table.carbFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showFpe => $composableBuilder(
    column: $table.showFpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fpeFactor => $composableBuilder(
    column: $table.fpeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
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

  ColumnOrderings<double> get carbFactor => $composableBuilder(
    column: $table.carbFactor,
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

  ColumnOrderings<bool> get darkMode => $composableBuilder(
    column: $table.darkMode,
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

  GeneratedColumn<double> get carbFactor => $composableBuilder(
    column: $table.carbFactor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showFpe =>
      $composableBuilder(column: $table.showFpe, builder: (column) => column);

  GeneratedColumn<double> get fpeFactor =>
      $composableBuilder(column: $table.fpeFactor, builder: (column) => column);

  GeneratedColumn<bool> get darkMode =>
      $composableBuilder(column: $table.darkMode, builder: (column) => column);
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
                Value<double> carbFactor = const Value.absent(),
                Value<bool> showFpe = const Value.absent(),
                Value<double?> fpeFactor = const Value.absent(),
                Value<bool> darkMode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsTableCompanion(
                id: id,
                carbUnit: carbUnit,
                carbFactor: carbFactor,
                showFpe: showFpe,
                fpeFactor: fpeFactor,
                darkMode: darkMode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required CarbUnit carbUnit,
                required double carbFactor,
                Value<bool> showFpe = const Value.absent(),
                Value<double?> fpeFactor = const Value.absent(),
                Value<bool> darkMode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsTableCompanion.insert(
                id: id,
                carbUnit: carbUnit,
                carbFactor: carbFactor,
                showFpe: showFpe,
                fpeFactor: fpeFactor,
                darkMode: darkMode,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealsTableTableTableManager get mealsTable =>
      $$MealsTableTableTableManager(_db, _db.mealsTable);
  $$UserSettingsTableTableTableManager get userSettingsTable =>
      $$UserSettingsTableTableTableManager(_db, _db.userSettingsTable);
}
