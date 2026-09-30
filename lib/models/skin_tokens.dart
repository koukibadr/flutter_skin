import 'package:material_ui/material_ui.dart' show ColorScheme;

class SkinTokens {
  final ColorScheme colors;
  final ColorScheme? darkColors;
  final SkinTypography typography;

  const SkinTokens({
    required this.colors,
    required this.typography,
    this.darkColors,
  });
}

class SkinTypography {
  final String? fontFamily;

  const SkinTypography({this.fontFamily});
}
