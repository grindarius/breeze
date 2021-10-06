import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:breeze/helpers/helpers.dart';
import 'package:breeze/models/color_map.dart';

ColorMap darkGrayColorCode = ColorMap(40, 40, 40, 1.0);
ColorMap lightGrayColorCode = ColorMap(59, 59, 59, 1.0);
ColorMap midnightBlueColorCode = ColorMap(15, 8, 75, 1.0);
ColorMap darkCornflowerBlueColorCode = ColorMap(38, 64, 139, 1.0);
ColorMap babyPowderWhiteColorCode = ColorMap(255, 255, 252, 1.0);
ColorMap maximumPurpleColorCode = ColorMap(127, 41, 130, 1.0);

Color darkGray = Color.fromRGBO(
  darkGrayColorCode.r,
  darkGrayColorCode.g,
  darkGrayColorCode.b,
  darkGrayColorCode.o
);
Color lightGray = Color.fromRGBO(
  lightGrayColorCode.r,
  lightGrayColorCode.g,
  lightGrayColorCode.b,
  lightGrayColorCode.o,
);
Color midnightBlue = Color.fromRGBO(
  midnightBlueColorCode.r,
  midnightBlueColorCode.g,
  midnightBlueColorCode.b,
  midnightBlueColorCode.o
);
Color darkCornflowerBlue = Color.fromRGBO(
  darkCornflowerBlueColorCode.r,
  darkCornflowerBlueColorCode.g,
  darkCornflowerBlueColorCode.b,
  darkCornflowerBlueColorCode.o
);
Color babyPowderWhite = Color.fromRGBO(
  babyPowderWhiteColorCode.r,
  babyPowderWhiteColorCode.g,
  babyPowderWhiteColorCode.b,
  babyPowderWhiteColorCode.o
);
Color maximumPurple = Color.fromRGBO(
  maximumPurpleColorCode.r,
  maximumPurpleColorCode.g,
  maximumPurpleColorCode.b,
  maximumPurpleColorCode.o
);

Map<int, Color> darkGrayMap = generateColorMap(darkGrayColorCode);
Map<int, Color> lightGrayMap = generateColorMap(lightGrayColorCode);
Map<int, Color> midnightBlueMap = generateColorMap(midnightBlueColorCode);
Map<int, Color> darkCornflowerBlueMap = generateColorMap(darkCornflowerBlueColorCode);
Map<int, Color> babyPowderWhiteMap = generateColorMap(babyPowderWhiteColorCode);
Map<int, Color> maximumPurpleMap = generateColorMap(maximumPurpleColorCode);

MaterialColor darkGrayMaterial = MaterialColor(
  darkGrayColorCode.hex,
  darkGrayMap
);
MaterialColor lightGrayMaterial = MaterialColor(
  lightGrayColorCode.hex,
  lightGrayMap
);
MaterialColor midnightBlueMaterial = MaterialColor(
  midnightBlueColorCode.hex,
  midnightBlueMap
);
MaterialColor darkCornflowerBlueMaterial = MaterialColor(
  darkCornflowerBlueColorCode.hex, 
  darkCornflowerBlueMap
);
MaterialColor babyPowderWhiteMaterial = MaterialColor(
  babyPowderWhiteColorCode.hex,
  babyPowderWhiteMap
);
MaterialColor maximumPurpleMaterial = MaterialColor(
  maximumPurpleColorCode.hex,
  maximumPurpleMap
);
