enum InsulinBlockId { morning, midday, evening, night }

extension InsulinBlockIdX on InsulinBlockId {
  String get key => switch (this) {
        InsulinBlockId.morning => 'morning',
        InsulinBlockId.midday => 'midday',
        InsulinBlockId.evening => 'evening',
        InsulinBlockId.night => 'night',
      };

  String get label => switch (this) {
        InsulinBlockId.morning => 'Früh',
        InsulinBlockId.midday => 'Mittag',
        InsulinBlockId.evening => 'Abend',
        InsulinBlockId.night => 'Nacht',
      };

  int get order => switch (this) {
        InsulinBlockId.morning => 0,
        InsulinBlockId.midday => 1,
        InsulinBlockId.evening => 2,
        InsulinBlockId.night => 3,
      };

  static InsulinBlockId fromKey(String key) => switch (key) {
        'morning' => InsulinBlockId.morning,
        'midday' => InsulinBlockId.midday,
        'evening' => InsulinBlockId.evening,
        'night' => InsulinBlockId.night,
        _ => InsulinBlockId.morning,
      };

  static List<InsulinBlockId> get ordered =>
      [InsulinBlockId.morning, InsulinBlockId.midday, InsulinBlockId.evening, InsulinBlockId.night];
}
