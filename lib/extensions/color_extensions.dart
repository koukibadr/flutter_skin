import 'dart:ui';
import 'package:flutter/services.dart';

extension ColorExtensions on String {
  Color toHexColor() {
    final hexColor = replaceAll('#', '');
    return Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }
}

extension ColorToHex on Color {
  String toHexString() {
    return '#${toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }
}
