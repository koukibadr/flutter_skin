import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_extensions.dart';

ColorScheme colorSchemeFromJson(Map<String, dynamic> map) {
  return ColorScheme(
    primary: (map['primary'] as String?)?.toHexColor() ?? Colors.blue,
    secondary: (map['secondary'] as String?)?.toHexColor() ?? Colors.green,
    secondaryContainer:
        (map['secondaryContainer'] as String?)?.toHexColor() ??
        Colors.green[100]!,
    surface: (map['surface'] as String?)?.toHexColor() ?? Colors.white,
    background:
        (map['background'] as String?)?.toHexColor() ?? Colors.grey[200]!,
    error: (map['error'] as String?)?.toHexColor() ?? Colors.red,
    onPrimary: (map['onPrimary'] as String?)?.toHexColor() ?? Colors.white,
    onSecondary: (map['onSecondary'] as String?)?.toHexColor() ?? Colors.white,
    onSurface: (map['onSurface'] as String?)?.toHexColor() ?? Colors.black,
    onBackground:
        (map['onBackground'] as String?)?.toHexColor() ?? Colors.black,
    onError: (map['onError'] as String?)?.toHexColor() ?? Colors.white,
    brightness: map['brightness'] == 'dark'
        ? Brightness.dark
        : Brightness.light,
  );
}
