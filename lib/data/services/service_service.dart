import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/supabase_client.dart';
import '../models/service.dart';

class ServiceService {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<List<Service>> fetchServices() async {
    // Tidak pakai .execute() lagi di Supabase v2
    final List<dynamic> data = await _client
        .from('services')
        .select()
        .eq('is_active', true)
        .order('id');

    return data.map((e) => Service.fromMap(e as Map<String, dynamic>)).toList();
  }
}
