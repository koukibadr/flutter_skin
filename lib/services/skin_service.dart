import 'package:flutter_skin/models/skin_keys.dart';
import 'package:flutter_skin/models/skin_model.dart';
import 'package:flutter_skin/services/supabase_client.dart';

class SkinService {
  static final SkinService _instance = SkinService._();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<SkinKeys?> fetchProjectKeys(String key) async {
    try {
      final response = await SupabaseClient().keys
          .select()
          .eq('key', key)
          .eq('is_active', true)
          .single();

      return SkinKeys.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<SkinModel?> getSkin(String key) async {
    try {
      final skinKeys = await fetchProjectKeys(key);
      if (skinKeys == null) return null;

      final response = await SupabaseClient().skins
          .select()
          .eq('project_id', skinKeys.projectId)
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
