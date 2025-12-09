import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/supabase_client.dart';
import '../models/order.dart';

class OrderService {
  final SupabaseClient _client = SupabaseClientManager.client;

  Future<int> createOrder({
    required String addressDetail,
    required DateTime pickupTime,
    required DateTime deliveryTime,
    required int totalPrice,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User belum login');

    // insert alamat sederhana
    final addr = await _client
        .from('addresses')
        .insert({
          'user_id': userId,
          'label': 'Alamat Utama',
          'detail': addressDetail,
          'is_default': true,
        })
        .select('id')
        .single();
    final addressId = addr['id'] as int;

    final order = await _client
        .from('orders')
        .insert({
          'user_id': userId,
          'address_id': addressId,
          'pickup_time': pickupTime.toIso8601String(),
          'delivery_time': deliveryTime.toIso8601String(),
          'status': 'PESANAN_DITERIMA',
          'total_price': totalPrice,
        })
        .select('id')
        .single();

    return order['id'] as int;
  }

  Future<Order?> fetchOrderById(int orderId) async {
    final data = await _client
        .from('orders')
        .select()
        .eq('id', orderId)
        .maybeSingle();
    if (data == null) return null;
    return Order.fromMap(data);
  }
}
