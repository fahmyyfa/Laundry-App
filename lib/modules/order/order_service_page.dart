import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OrderServicePage extends StatefulWidget {
  const OrderServicePage({super.key});

  @override
  State<OrderServicePage> createState() => _OrderServicePageState();
}

class _OrderServicePageState extends State<OrderServicePage> {
  int _selectedIndex = 0;

  // List layanan laundry (bisa kamu sesuaikan)
  final List<Map<String, dynamic>> _services = const [
    {
      'id': 'express',
      'name': 'Cuci Cepat',
      'subtitle': 'Selesai kurang dari 24 jam',
      'price': 12000, // per kg
      'icon': Icons.flash_on_rounded,
    },
    {
      'id': 'regular',
      'name': 'Cuci Reguler',
      'subtitle': 'Hemat & rapi',
      'price': 9000,
      'icon': Icons.local_laundry_service_rounded,
    },
    {
      'id': 'bedcover',
      'name': 'Bed Cover',
      'subtitle': 'Bersih total',
      'price': 25000,
      'icon': Icons.bed_rounded,
    },
    {
      'id': 'iron_only',
      'name': 'Setrika Saja',
      'subtitle': 'Licin & wangi',
      'price': 8000,
      'icon': Icons.iron_rounded,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Kalau dari HomePage kita kirim nama layanan, jadikan default terpilih
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      final index = _services.indexWhere((s) => s['name']?.toString() == args);
      if (index != -1) {
        _selectedIndex = index;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedService = _services[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Layanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        children: [
          Text(
            'Layanan Laundry',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.textMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih jenis layanan yang kamu butuhkan.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_services.length, (index) {
            final item = _services[index];
            final bool isSelected = index == _selectedIndex;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: isSelected ? AppColors.primarySoft : Colors.white,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                        color: Colors.black.withValues(alpha: 0.04),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primarySoft,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          item['icon'] as IconData,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle'] as String,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Rp ${(item['price'] as int).toString()} / kg',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_off_rounded,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: FilledButton(
          onPressed: () {
            // Kirim data layanan ke halaman alamat
            Navigator.of(context).pushNamed(
              AppConstants.routeOrderAddress,
              arguments: {
                'service': selectedService,
              },
            );
          },
          child: const Text('Lanjutkan'),
        ),
      ),
    );
  }
}
