class SkinModel {
  final Colors colors;
  
  SkinModel({
    required this.colors,
  });

  /// Factory constructor to create SkinModel from a map
  factory SkinModel.fromMap(Map<String, dynamic> map) {
    return SkinModel(
      colors: Colors.fromMap(map['colors'] as Map<String, dynamic>? ?? {}),
    );
  }

  /// Convert SkinModel to map
  Map<String, dynamic> toMap() {
    return {
      'colors': colors.toMap(),
    };
  }
}

class Colors {
  final String? primary;
  final String? secondary;
  final String? background;
  final String? surface;
  final String? onPrimary;
  final String? text;
  final String? textMuted;
  final String? error;

  Colors({
    this.primary,
    this.secondary,
    this.background,
    this.surface,
    this.onPrimary,
    this.text,
    this.textMuted,
    this.error,
  });

  factory Colors.fromMap(Map<String, dynamic> map) {
    return Colors(
      primary: map['primary'] as String?,
      secondary: map['secondary'] as String?,
      background: map['background'] as String?,
      surface: map['surface'] as String?,
      onPrimary: map['on_primary'] as String?,
      text: map['text'] as String?,
      textMuted: map['text_muted'] as String?,
      error: map['error'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primary': primary,
      'secondary': secondary,
      'background': background,
      'surface': surface,
      'on_primary': onPrimary,
      'text': text,
      'text_muted': textMuted,
      'error': error,
    };
  }
}