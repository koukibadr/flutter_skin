import 'package:flutter_skin/models/project_model.dart';
import 'package:flutter_skin/services/supabase_client.dart';

class ProjectService {
  static final ProjectService _instance = ProjectService._();

  ProjectService._();

  factory ProjectService() {
    return _instance;
  }

  Future<ProjectModel?> getProject(String projectId) async {
    try {
      final response = await SupabaseClient().projects
          .select()
          .eq('id', projectId)
          .single();

      return ProjectModel.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<ProjectModel?> getProjectByDeveloper(String developerId) async {
    try {
      final response = await SupabaseClient().projects
          .select()
          .eq('developer_id', developerId)
          .single();

      return ProjectModel.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
