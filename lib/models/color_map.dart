/// Helper class to help manipulate between hex value and RGBA value to create `MaterialColor`
class ColorMap {
  final int r;
  final int g;
  final int b;
  final double o;

  ColorMap(this.r, this.g, this.b, this.o);

  /// Converts stored RGBA value to hex color integer.
  int get hex {
    String rString = r.toRadixString(16).padLeft(2, '0');
    String gString = g.toRadixString(16).padLeft(2, '0');
    String bString = b.toRadixString(16).padLeft(2, '0');
    String oString = (o * 255).toInt().toRadixString(16).padLeft(2, '0');

    String hexString = '$oString$rString$gString$bString';
    return int.parse(hexString, radix: 16);
  }
}
