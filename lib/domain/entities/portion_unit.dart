/// Einheit zur Angabe einer Portionsgröße.
enum PortionUnit { gramm, piece, portion; }

/// Anzeigename der Einheit für die Benutzeroberfläche.
extension PortionUnitExt on PortionUnit {
  String get label {
    switch (this) {
      case PortionUnit.gramm:
        return 'Gramm';
      case PortionUnit.piece:
        return 'Stück';
      case PortionUnit.portion:
        return 'Portion(en)';
    }
  }
}