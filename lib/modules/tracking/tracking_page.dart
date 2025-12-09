import 'package:flutter/material.dart';
import '../../data/models/order.dart';
import '../../data/services/order_service.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final _orderService = OrderService();
  late Future<Order?> _orderFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final orderId = ModalRoute.of(context)!.settings.arguments as int?;
    if (orderId != null) {
      _orderFuture = _orderService.fetchOrderById(orderId);
    } else {
      _orderFuture = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lacak Pesanan')),
      body: FutureBuilder<Order?>(
        future: _orderFuture,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snap.hasData || snap.data == null) {
            return const Center(child: Text('Pesanan tidak ditemukan.'));
          }
          final order = snap.data!;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Status: ${order.status}'),
                const SizedBox(height: 16),
                const Text('Tahapan (contoh):'),
                const SizedBox(height: 6),
                const Text('- PESANAN_DITERIMA'),
                const Text('- DIJEMPUT'),
                const Text('- SEDANG_DICUCI'),
                const Text('- QUALITY_CHECK'),
                const Text('- DIANTAR'),
                const Text('- SELESAI'),
                const Spacer(),
                const Text(
                  'Update status bisa dilakukan di tabel "orders" Supabase.',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
