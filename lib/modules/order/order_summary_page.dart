import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../data/models/service.dart';
import '../../data/services/order_service.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  final _orderService = OrderService();
  bool _loading = false;

  Future<void> _confirm(Map<String, dynamic> args) async {
    setState(() => _loading = true);
    try {
      final id = await _orderService.createOrder(
        addressDetail: args['address'] as String,
        pickupTime: args['pickupDate'] as DateTime,
        deliveryTime: args['deliveryDate'] as DateTime,
        totalPrice: args['total'] as int,
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppConstants.routeOrderSuccess,
        ModalRoute.withName(AppConstants.routeHome),
        arguments: id,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal membuat pesanan: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final service = args['service'] as Service;
    final kg = args['kg'] as int;
    final total = args['total'] as int;
    final address = args['address'] as String;
    final pickup = args['pickupDate'] as DateTime;
    final delivery = args['deliveryDate'] as DateTime;

    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layanan: ${service.name}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Perkiraan berat: $kg kg'),
            const SizedBox(height: 8),
            Text('Pickup: $pickup'),
            Text('Pengantaran: $delivery'),
            const SizedBox(height: 8),
            Text('Alamat: $address'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rp $total',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : () => _confirm(args),
                  child: Text(_loading ? 'Memproses...' : 'Konfirmasi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
