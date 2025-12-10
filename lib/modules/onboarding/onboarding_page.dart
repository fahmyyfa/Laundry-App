import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _controller;
  int _currentPage = 0;

  final _pages = const [
    (
      title: 'Cepat & Mudah',
      description: 'Pesan layanan laundry hanya dalam beberapa langkah.',
      icon: Icons.local_laundry_service_rounded,
    ),
    (
      title: 'Antar Jemput',
      description:
          'Kurir menjemput dan mengantarkan kembali pakaianmu tepat waktu.',
      icon: Icons.delivery_dining_rounded,
    ),
    (
      title: 'Tracking Pesanan',
      description: 'Pantau status cucianmu secara real-time dari aplikasi.',
      icon: Icons.show_chart_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skip() {
    // ⬇️ PENTING: gunakan route dari AppConstants
    Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
  }

  void _next() {
    if (_currentPage == _pages.length - 1) {
      // Halaman terakhir → arahkan ke login
      Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // pakai warna surface (bukan background yang deprecated)
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Top bar: tombol Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text('Lewati'),
                ),
              ),
              const SizedBox(height: 16),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ilustrasi lingkaran
                        Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primarySoft,
                          ),
                          child: Icon(
                            page.icon,
                            size: 96,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Dot indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 6,
                    width: _currentPage == index ? 18 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primary
                          : AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Tombol bawah: Lanjut / Mulai
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _next,
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Mulai' : 'Lanjut',
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
