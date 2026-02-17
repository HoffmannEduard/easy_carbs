/// Einheit zur Angabe von Kohlenhydraten.
/// - [CarbUnit.be]: Broteinheit (1 BE = 12 g Kohlenhydrate)
/// - [CarbUnit.ke]: Kohlenhydrateinheit (1 KE = 10 g Kohlenhydrate)
enum CarbUnit { be, ke; }

/// Kurzlabel zur Anzeige in der Benutzeroberfläche.
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
