import 'dart:ui';

extension ColorExtensions on String {
  Color toHexColor() {
    final hexColor = replaceAll('#', '');
    return Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }
}