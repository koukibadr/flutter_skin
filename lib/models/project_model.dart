class ProjectModel {
  final String id;
  final String developerId;
  final String appName;
  final String description;
  final String activeSkinId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ProjectModel({
    required this.id,
    required this.developerId,
    required this.appName,
    required this.description,
    required this.activeSkinId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] as String,
      developerId: map['developer_id'] as String,
      appName: map['app_name'] as String,
      description: map['description'] as String,
      activeSkinId: map['active_skin_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'developer_id': developerId,
      'app_name': appName,
      'description': description,
      'active_skin_id': activeSkinId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
