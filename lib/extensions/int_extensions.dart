extension IntExtensions on int {
  /// Returns the int as a String with a leading zero if teh int is a single digit.
  String toZeroPaddedString() {
    return toString().padLeft(2, '0');
  }
}
