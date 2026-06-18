import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_scheme_extensions.dart';

class SkinModel {
  final String id;
  final String projectId;
  final bool isActive;
  final int version;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final DateTime? deletedAt;
  final ColorScheme? colors;

  SkinModel({
    required this.id,
    required this.projectId,
    required this.isActive,
    required this.version,
    required this.createdAt,
    required this.colors,
    this.publishedAt,
    this.deletedAt,
  });

  /// Factory constructor to create SkinModel from a map
  factory SkinModel.fromMap(Map<String, dynamic> map) {
    return SkinModel(
      id: map['id'] as String? ?? '',
      projectId: map['projectId'] as String? ?? '',
      isActive: map['isActive'] as bool? ?? false,
      version: map['version'] as int? ?? 1,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
      publishedAt: map['publishedAt'] != null
          ? DateTime.parse(map['publishedAt'] as String)
          : null,
      deletedAt: map['deletedAt'] != null
          ? DateTime.parse(map['deletedAt'] as String)
          : null,
      colors: fromSchemaString(map['tokens'])?.colors,
    );
  }

  /// Convert SkinModel to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'isActive': isActive,
      'version': version,
      'createdAt': createdAt.toIso8601String(),
      'publishedAt': publishedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  /// Parse SkinModel from schema string (JSON format)
  static SkinModel? fromSchemaString(Map<String, dynamic> schemaString) {
    try {
      return SkinModel(
        id: '',
        projectId: '',
        isActive: false,
        version: 1,
        createdAt: DateTime.now(),
        colors: colorSchemeFromJson(schemaString['colors']),
      );
    } catch (e) {
      return null;
    }
  }
}
