extension OneDecimalFormat on double? {
  String to1dp() {
    return this == null ? '' : this!.toStringAsFixed(1);
  }
}
