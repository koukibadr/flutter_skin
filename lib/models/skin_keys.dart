class SkinKeys {
  final String projectId;
  final String teamId;

  SkinKeys({required this.projectId, required this.teamId});

  factory SkinKeys.fromMap(Map<String, dynamic> map) {
    return SkinKeys(
      projectId: map['project_id'] as String? ?? '',
      teamId: map['team_id'] as String? ?? '',
    );
  }
}
