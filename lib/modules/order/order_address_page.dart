import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OrderAddressPage extends StatefulWidget {
  const OrderAddressPage({super.key});

  @override
  State<OrderAddressPage> createState() => _OrderAddressPageState();
}

class _OrderAddressPageState extends State<OrderAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  TimeOfDay? _pickupTime;

  Map<String, dynamic> _baseData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _baseData = Map<String, dynamic>.from(args);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: now,
    );
    if (picked != null) {
      setState(() {
        _pickupTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final service = _baseData['service'] as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penjemputan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            if (service != null) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.primarySoft,
                ),
                child: Row(
                  children: [
                    Icon(
                      service['icon'] as IconData? ??
                          Icons.local_laundry_service_rounded,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'] as String? ?? '',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Mulai dari Rp ${(service['price'] as int?) ?? 0} / kg',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            Text(
              'Alamat Penjemputan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Masukkan alamat lengkapmu di sini',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Catatan untuk kurir (opsional)',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Contoh: rumah pagar hijau, bel kanan',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Jadwal Penjemputan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              onTap: _pickTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.15),
                ),
              ),
              title: Text(
                _pickupTime == null
                    ? 'Pilih jam penjemputan'
                    : 'Jam ${_pickupTime!.hour.toString().padLeft(2, '0')}:${_pickupTime!.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.access_time_rounded),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            if (_pickupTime == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Silakan pilih jam penjemputan terlebih dahulu'),
                ),
              );
              return;
            }

            final data = {
              ..._baseData,
              'address': _addressController.text.trim(),
              'note': _noteController.text.trim(),
              'pickupTime': _pickupTime,
            };

            Navigator.of(context).pushNamed(
              AppConstants.routeOrderSummary,
              arguments: data,
            );
          },
          child: const Text('Lanjut ke Ringkasan'),
        ),
      ),
    );
  }
}
