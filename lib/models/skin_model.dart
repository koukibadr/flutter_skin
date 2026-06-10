class SkinModel {
  final String id;
  final String projectId;
  final String schema;
  final bool isActive;
  final int version;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final DateTime? deletedAt;
  final Colors colors;
  
  SkinModel({
    required this.id,
    required this.projectId,
    required this.schema,
    required this.isActive,
    required this.version,
    required this.createdBy,
    required this.createdAt,
    required this.colors,
    this.publishedAt,
    this.deletedAt,
  });

  /// Factory constructor to create SkinModel from a map
  factory SkinModel.fromMap(Map<String, dynamic> map) {
    return SkinModel(
      id: map['id'] as String? ?? '',
      projectId: map['project_id'] as String? ?? '',
      schema: map['schema'] as String? ?? '',
      isActive: map['is_active'] as bool? ?? false,
      version: map['version'] as int? ?? 1,
      createdBy: map['created_by'] as String? ?? '',
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : DateTime.now(),
      publishedAt: map['published_at'] != null ? DateTime.parse(map['published_at'] as String) : null,
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
      colors: fromSchemaString(map['schema'] as String? ?? '')?.colors ?? Colors(),
    );
  }

  /// Convert SkinModel to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_id': projectId,
      'schema': schema,
      'is_active': isActive,
      'version': version,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'published_at': publishedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'colors': colors.toMap(),
    };
  }

  /// Parse SkinModel from schema string (JSON format)
  static SkinModel? fromSchemaString(String schemaString) {
    try {
      final jsonData = _decodeJson(schemaString);
      if (jsonData == null) return null;

      return SkinModel(
        id: '',
        projectId: '',
        schema: schemaString,
        isActive: false,
        version: 1,
        createdBy: '',
        createdAt: DateTime.now(),
        colors: Colors.fromMap(jsonData['colors'] as Map<String, dynamic>? ?? {}),
      );
    } catch (e) {
      return null;
    }
  }

  static dynamic _decodeJson(String jsonString) {
    try {
      final colorsMatch = RegExp(r'"colors"\s*:\s*(\{[^}]+\})').firstMatch(jsonString);
      if (colorsMatch == null) return null;

      final colorsJson = colorsMatch.group(1);
      return {
        'colors': _parseColorsFromJson(colorsJson ?? '{}'),
      };
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> _parseColorsFromJson(String colorsJson) {
    try {
      final colors = <String, dynamic>{};
      final colorPattern = RegExp(r'"(\w+)"\s*:\s*"([^"]+)"');
      final matches = colorPattern.allMatches(colorsJson);

      for (final match in matches) {
        colors[match.group(1)!] = match.group(2)!;
      }

      return colors;
    } catch (e) {
      return {};
    }
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