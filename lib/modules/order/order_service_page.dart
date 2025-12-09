import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../data/models/service.dart';

class OrderServicePage extends StatefulWidget {
  const OrderServicePage({super.key});

  @override
  State<OrderServicePage> createState() => _OrderServicePageState();
}

class _OrderServicePageState extends State<OrderServicePage> {
  int _kg = 1;
  DateTime _pickupDate = DateTime.now().add(const Duration(hours: 2));
  DateTime _deliveryDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)!.settings.arguments as Service;
    final total = service.basePrice * _kg;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(service.description),
            const SizedBox(height: 16),
            const Text('Perkiraan berat cucian (kg)'),
            Row(
              children: [
                IconButton(
                  onPressed: _kg > 1 ? () => setState(() => _kg--) : null,
                  icon: const Icon(Icons.remove),
                ),
                Text('$_kg kg'),
                IconButton(
                  onPressed: () => setState(() => _kg++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Jadwal Pickup'),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _pickupDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 7)),
                );
                if (picked != null) {
                  setState(() {
                    _pickupDate = DateTime(
                      picked.year,
                      picked.month,
                      picked.day,
                      _pickupDate.hour,
                    );
                  });
                }
              },
              child: Text(_pickupDate.toString()),
            ),
            const Text('Jadwal Pengantaran'),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _deliveryDate,
                  firstDate: _pickupDate,
                  lastDate: DateTime.now().add(const Duration(days: 14)),
                );
                if (picked != null) {
                  setState(() => _deliveryDate = picked);
                }
              },
              child: Text(_deliveryDate.toString()),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Estimasi: Rp $total',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.routeOrderAddress,
                      arguments: {
                        'service': service,
                        'kg': _kg,
                        'pickupDate': _pickupDate,
                        'deliveryDate': _deliveryDate,
                        'total': total,
                      },
                    );
                  },
                  child: const Text('Lanjut'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
