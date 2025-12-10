import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: gantikan dengan data user & pesanan aktif dari Supabase
    const fakeUserName = 'Fahmi';
    const hasActiveOrder = true;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(
          children: [
            // Avatar lingkaran
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarySoft,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, $fakeUserName 👋',
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    'Siap bantu cucian kamu hari ini',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // TODO: panggil refresh data dari backend
            await Future<void>.delayed(const Duration(milliseconds: 700));
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            children: [
              if (hasActiveOrder) ...[
                _ActiveOrderCard(
                  orderId: '#123456',
                  status: 'Sedang Dicuci',
                  progress: 0.6,
                  eta: 'Selesai dalam 2 jam',
                ),
                const SizedBox(height: 20),
              ],
              _PromoBanner(
                title: 'Diskon 30% untuk pelanggan baru',
                subtitle: 'Gunakan kode FRESH30 saat checkout.',
              ),
              const SizedBox(height: 20),
              _ServiceGrid(),
              const SizedBox(height: 24),
              Text(
                'Ringkasan Pesanan Terakhir',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _LastOrdersSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              // TODO: arahkan ke flow buat pesanan baru
              Navigator.of(context).pushNamed('/order/new');
            },
            icon: const Icon(Icons.add_rounded),
            label: const Text('Mulai Pesanan Baru'),
          ),
        ),
      ),
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final double progress;
  final String eta;

  const _ActiveOrderCard({
    required this.orderId,
    required this.status,
    required this.progress,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.local_laundry_service_rounded,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pesanan Aktif',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMain,
                      ),
                    ),
                    Text(
                      orderId,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    status,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              borderRadius: BorderRadius.circular(999),
              backgroundColor: AppColors.primarySoft,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time_rounded,
                    size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  eta,
                  style: theme.textTheme.bodyMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: arahkan ke halaman tracking
                    Navigator.of(context).pushNamed('/tracking');
                  },
                  child: const Text('Lihat Detail'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PromoBanner({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF4F8CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {
                    // TODO: buka halaman promo
                  },
                  child: const Text('Lihat promo'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.local_offer_rounded,
            size: 40,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final services = [
      (
        icon: Icons.local_laundry_service_rounded,
        title: 'Cuci Cepat',
        subtitle: 'Selesai < 24 jam'
      ),
      (
        icon: Icons.local_laundry_service_outlined,
        title: 'Cuci Reguler',
        subtitle: 'Hemat & rapi'
      ),
      (
        icon: Icons.checkroom_rounded,
        title: 'Bed Cover',
        subtitle: 'Bersih total'
      ),
      (
        icon: Icons.iron_rounded,
        title: 'Setrika Saja',
        subtitle: 'Licin & rapi'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layanan Kami',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final item = services[index];
            return GestureDetector(
              onTap: () {
                // TODO: langsung mulai pesanan dengan layanan tersebut
                Navigator.of(context).pushNamed(
                  '/order/new',
                  arguments: item.title,
                );
              },
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primarySoft,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          item.icon,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.title,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _LastOrdersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: ganti dengan data riwayat pesanan nyata dari Supabase
    final lastOrders = [
      ('#123456', 'Selesai', 'Cuci Reguler • 3 kg', 'Kemarin'),
      ('#123455', 'Dibatal­kan', 'Cuci Cepat • 2 kg', '2 hari lalu'),
    ];

    return Column(
      children: lastOrders
          .map(
            (o) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primarySoft,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(
                    o.$1,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMain,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(o.$3, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 2),
                      Text(
                        o.$4,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  trailing: Text(
                    o.$2,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: o.$2 == 'Selesai'
                          ? AppColors.accent
                          : AppColors.danger,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    // TODO: buka detail pesanan
                  },
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
