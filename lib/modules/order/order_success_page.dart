import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pesanan Berhasil'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Icon centang besar
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarySoft,
              ),
              child: const Center(
                child: Icon(
                  Icons.check_rounded,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Pesananmu berhasil dibuat! 🎉',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kami sedang menyiapkan penjemputan pakaianmu. '
              'Kamu bisa melihat detail dan status pesanan di halaman tracking.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            // Tombol "Lacak Pesanan"
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // arahkan ke halaman tracking
                  Navigator.of(context).pushNamed('/tracking');
                },
                child: const Text('Lacak Pesanan'),
              ),
            ),
            const SizedBox(height: 12),
            // Tombol "Kembali ke Beranda"
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // kembali ke home dan hapus stack
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppConstants.routeHome,
                    (route) => false,
                  );
                },
                child: const Text('Kembali ke Beranda'),
              ),
            ),
            const Spacer(),
            Text(
              'Terima kasih sudah menggunakan JoySpin Laundry 💙',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
