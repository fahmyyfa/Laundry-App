import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments;

    final data = args is Map<String, dynamic>
        ? Map<String, dynamic>.from(args)
        : <String, dynamic>{};

    final service = data['service'] as Map<String, dynamic>?;
    final address = data['address'] as String? ?? '-';
    final note = data['note'] as String? ?? '-';
    final pickupTime = data['pickupTime'] as TimeOfDay?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        children: [
          Text(
            'Detail Layanan',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primarySoft,
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  service?['icon'] as IconData? ??
                      Icons.local_laundry_service_rounded,
                  color: AppColors.primary,
                ),
              ),
              title: Text(
                service?['name'] as String? ?? 'Layanan tidak diketahui',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                service?['subtitle'] as String? ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              trailing: Text(
                'Rp ${(service?['price'] as int? ?? 0).toString()} / kg',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Alamat & Jadwal',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          address,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        pickupTime == null
                            ? '-'
                            : 'Jam ${pickupTime.hour.toString().padLeft(2, '0')}:${pickupTime.minute.toString().padLeft(2, '0')}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.sticky_note_2_outlined,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note.isEmpty ? '-' : note,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Estimasi Biaya',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                children: [
                  _rowPrice(
                    theme,
                    'Estimasi berat',
                    '3 kg', // nanti bisa diganti input real
                  ),
                  const SizedBox(height: 6),
                  _rowPrice(
                    theme,
                    'Harga per kg',
                    'Rp ${(service?['price'] as int? ?? 0).toString()}',
                  ),
                  const Divider(height: 20),
                  _rowPrice(
                    theme,
                    'Total estimasi',
                    'Rp ${(3 * (service?['price'] as int? ?? 0)).toString()}',
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppConstants.routeOrderSuccess,
              arguments: data,
            );
          },
          child: const Text('Konfirmasi Pesanan'),
        ),
      ),
    );
  }

  Widget _rowPrice(
    ThemeData theme,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: isBold ? AppColors.textMain : AppColors.textMain,
          ),
        ),
      ],
    );
  }
}
