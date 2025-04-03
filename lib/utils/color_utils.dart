import 'dart:math';
import 'package:flutter/material.dart';

/// Converts a [Color] object to a string representation.
String colorToString(Color color) {
  final int a = color.a.round();
  final int r = (color.r * 255).floor();
  final int g = (color.g * 255).floor();
  final int b = (color.b * 255).floor();
  return "alpha=$a, red=$r, green=$g, blue=$b";
}

/// Generates a random color using a [Random] instance.
Color generateRandomColor(Random random) {
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
