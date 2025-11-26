enum CarbUnit { gramm, be, ke; }

extension CarbUnitExt on CarbUnit {
  String get label {
    switch (this) {
      case CarbUnit.gramm:
        return 'gramm';
      case CarbUnit.be:
        return 'BE';
      case CarbUnit.ke:
        return 'KE';
    }
  }
}
