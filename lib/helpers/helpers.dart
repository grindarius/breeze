import 'package:flutter/material.dart';

import 'package:breeze/models/color_map.dart';

/// Generates color map to be converted to `MaterialColor`.
Map<int, Color> generateColorMap(ColorMap color) {
  int initialColorShade = 0;
  int increment = 100;
  double initialColorOpacity = 1;

  List<int> numberList = [50] + List.generate(9, (_) => initialColorShade += increment, growable: true);
  Map<int, Color> colorList =  numberList.fold({}, (pervious, current) {
    pervious[current] = Color.fromRGBO(color.r, color.g, color.b, initialColorOpacity / 10);
    initialColorOpacity += 1;
    return pervious;
  });

  return colorList;
}
