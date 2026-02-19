/// Identifiziert die vier festen Insulin-Zeitblöcke eines Tages.
enum InsulinBlockId { morning, midday, evening, night }

/// Erweiterung mit Hilfsfunktionen für Persistenz, Anzeige und Sortierung.
extension InsulinBlockIdX on InsulinBlockId {
  String get key => switch (this) {
        InsulinBlockId.morning => 'morning',
        InsulinBlockId.midday => 'midday',
        InsulinBlockId.evening => 'evening',
        InsulinBlockId.night => 'night',
      };

  /// Kurzlabel zur Anzeige in der Benutzeroberfläche.
  String get label => switch (this) {
        InsulinBlockId.morning => 'Früh',
        InsulinBlockId.midday => 'Mittag',
        InsulinBlockId.evening => 'Abend',
        InsulinBlockId.night => 'Nacht',
      };

  /// Definierte Reihenfolge innerhalb eines Tages (0–3).
  int get order => switch (this) {
        InsulinBlockId.morning => 0,
        InsulinBlockId.midday => 1,
        InsulinBlockId.evening => 2,
        InsulinBlockId.night => 3,
      };

  /// Wandelt einen technischen Schlüssel zurück in eine [InsulinBlockId].
  /// Fällt bei unbekanntem Schlüssel auf `morning` zurück.
  static InsulinBlockId fromKey(String key) => switch (key) {
        'morning' => InsulinBlockId.morning,
        'midday' => InsulinBlockId.midday,
        'evening' => InsulinBlockId.evening,
        'night' => InsulinBlockId.night,
        _ => InsulinBlockId.morning,
      };

  /// Gibt alle Blöcke in definierter Tagesreihenfolge zurück.
  static List<InsulinBlockId> get ordered =>
      [InsulinBlockId.morning, InsulinBlockId.midday, InsulinBlockId.evening, InsulinBlockId.night];
}
