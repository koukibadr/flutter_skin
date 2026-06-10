import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static final SupabaseClient _instance = SupabaseClient._();

  SupabaseClient._();

  factory SupabaseClient() {
    return _instance;
  }

  static Future<void> initialize() async {
    /*await dotenv.load(
      fileName: '.env',
    );*/
    
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception('Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env file');
    }

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  SupabaseQueryBuilder get developers =>
      Supabase.instance.client.from('developers');

  SupabaseQueryBuilder get projects =>
      Supabase.instance.client.from('projects');

  SupabaseQueryBuilder get skins => Supabase.instance.client.from('skins');
}
