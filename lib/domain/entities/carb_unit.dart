enum CarbUnit { be, ke; }

extension CarbUnitExt on CarbUnit {
  String get label {
    switch (this) {
      case CarbUnit.be:
        return 'BE';
      case CarbUnit.ke:
        return 'KE';
    }
  }
}
