enum PortionUnit { gramm, piece, portion; }

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