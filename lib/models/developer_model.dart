class DeveloperModel {
  final String id;
  final String email;
  final String fullName;
  final String plan;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;

  DeveloperModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.plan,
    required this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  factory DeveloperModel.fromMap(Map<String, dynamic> map) {
    return DeveloperModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String,
      plan: map['plan'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'plan': plan,
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
