import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_scheme_extensions.dart';

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
  final ColorScheme? colors;

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
      schema: map['tokens'] as String? ?? '',
      isActive: map['is_active'] as bool? ?? false,
      version: map['version'] as int? ?? 1,
      createdBy: map['created_by'] as String? ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'] as String)
          : null,
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'] as String)
          : null,
      colors: fromSchemaString(map['tokens'] as String? ?? '')?.colors,
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
      //'colors': colors.toMap(),
    };
  }

  /// Parse SkinModel from schema string (JSON format)
  static SkinModel? fromSchemaString(String schemaString) {
    try {
      Map<String, dynamic>? jsonData = jsonDecode(schemaString);
      if (jsonData == null) return null;

      return SkinModel(
        id: '',
        projectId: '',
        schema: schemaString,
        isActive: false,
        version: 1,
        createdBy: '',
        createdAt: DateTime.now(),
        colors: colorSchemeFromJson(
          jsonData['colors'] as Map<String, dynamic>? ?? {},
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
