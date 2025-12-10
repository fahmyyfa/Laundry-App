import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:joyspin_laundry/core/constants.dart';

/// Wrapper sederhana untuk Supabase client
class SupabaseClientProvider {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    final c = _client;
    if (c == null) {
      throw StateError(
          'Supabase belum di-init. Panggil SupabaseClientProvider.init() di main().');
    }
    return c;
  }

  static Future<void> init({String? url, String? anonKey}) async {
    final supabaseUrl = url ?? AppConstants.supabaseUrl;
    final supabaseAnonKey = anonKey ?? AppConstants.supabaseAnonKey;

    final supabase = await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );

    _client = supabase.client;
  }
}
