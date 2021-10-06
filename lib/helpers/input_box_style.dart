import 'package:flutter/material.dart';

import 'package:breeze/constants/colors.dart';

/// Return standard input box style for most of the input boxes.
InputDecoration inputBoxStyle(String label, String hint) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: maximumPurple,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
    labelText: label,
    labelStyle: TextStyle(
      color: babyPowderWhite,
    ),
    hintText: hint,
    hintStyle: TextStyle(
      color: babyPowderWhiteMaterial.shade300,
      fontSize: 12,
    ),
  );
}
