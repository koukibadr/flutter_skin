import 'package:flutter_skin/models/developer_model.dart';
import 'package:flutter_skin/services/supabase_client.dart';

class DeveloperService {
  static final DeveloperService _instance = DeveloperService._();

  DeveloperService._();

  factory DeveloperService() {
    return _instance;
  }

  Future<DeveloperModel?> getDeveloper(String developerId) async {
    try {
      final response = await SupabaseClient().developers
          .select()
          .eq('id', developerId)
          .single();

      return DeveloperModel.fromMap(response as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
