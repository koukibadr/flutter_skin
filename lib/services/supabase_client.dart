import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final SupabaseClient _instance = SupabaseClient._();

  SupabaseClient._();

  factory SupabaseClient() {
    return _instance;
  }

  static Future<void> initialize() async {
    final supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
    final supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      throw Exception('Missing SUPABASE_URL or SUPABASE_ANON_KEY');
    }

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  SupabaseQueryBuilder get developers =>
      Supabase.instance.client.from('developers');

  SupabaseQueryBuilder get projects =>
      Supabase.instance.client.from('projects');

  SupabaseQueryBuilder get skins => Supabase.instance.client.from('skins');

  SupabaseQueryBuilder get keys => Supabase.instance.client.from('keys');
}
