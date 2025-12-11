import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments;
    final data = args is Map<String, dynamic>
        ? Map<String, dynamic>.from(args)
        : <String, dynamic>{};

    final service = data['service'] as Map<String, dynamic>?;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primarySoft,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 60,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Pesanan Berhasil!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Kami sudah menerima pesanan laundry kamu. Kurir akan segera menjemput cucian sesuai jadwal.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (service != null)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                        color: Colors.black.withValues(alpha: 0.06),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primarySoft,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          service['icon'] as IconData? ??
                              Icons.local_laundry_service_rounded,
                          color: AppColors.primary,
                        ),
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
                              'Order ID akan tampil di riwayat pesanan.',
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
              const Spacer(),
              FilledButton(
                onPressed: () {
                  // ke halaman tracking
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppConstants.routeTracking,
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Lacak Pesanan'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  // kembali ke Home
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppConstants.routeHome,
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
