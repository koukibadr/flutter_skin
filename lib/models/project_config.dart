import 'package:flutter_skin/models/skin_model.dart';

class ProjectConfig {
  final SkinModel? skin;
  final String? projectId;
  final String? teamId;
  final String? projectName;

  ProjectConfig({this.skin, this.projectId, this.teamId, this.projectName});

  factory ProjectConfig.fromMap(Map<String, dynamic> map) {
    return ProjectConfig(
      skin: map['skin'] != null ? SkinModel.fromMap(map['skin']) : null,
      projectId: map['projectId'] as String?,
      teamId: map['teamId'] as String?,
      projectName: map['projectName'] as String?,
    );
  }
}
