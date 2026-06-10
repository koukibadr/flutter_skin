import 'package:flutter_skin/models/skin_model.dart';
import 'package:flutter_skin/services/supabase_client.dart';

class SkinService {
  static final SkinService _instance = SkinService._();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<SkinModel?> getSkin(String developerId, String projectId) async {
    try {
      final response = await SupabaseClient().skins
          .select()
          .eq('project_id', projectId)
          .eq('created_by', developerId)
          .eq('is_active', true)
          .single();

      return SkinModel.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<SkinModel?> getSkinById(String skinId) async {
    try {
      final response = await SupabaseClient().skins
          .select()
          .eq('id', skinId)
          .single();

      return SkinModel.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
