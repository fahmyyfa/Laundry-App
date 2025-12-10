import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  final _pages = const [
    _OnboardModel(
      title: 'Cepat & Mudah',
      description: 'Pesan layanan laundry hanya dalam beberapa langkah.',
      icon: Icons.local_laundry_service_rounded,
    ),
    _OnboardModel(
      title: 'Pickup & Antar',
      description:
          'Kurir akan menjemput dan mengantar kembali pakaianmu tepat waktu.',
      icon: Icons.delivery_dining_rounded,
    ),
    _OnboardModel(
      title: 'Tracking Real-time',
      description:
          'Pantau status cucianmu: dijemput, dicuci, disetrika hingga selesai.',
      icon: Icons.timelapse_rounded,
    ),
  ];

  void _goNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      // TODO: arahkan ke login / home sesuai alurmu
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Top bar: Skip
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
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _OnboardSlide(model: page);
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) {
                    final selected = index == _currentIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: selected ? 22 : 8,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // CTA
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _goNext,
                  child: Text(
                    _currentIndex == _pages.length - 1
                        ? 'Mulai Sekarang'
                        : 'Lanjut',
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardModel {
  final String title;
  final String description;
  final IconData icon;

  const _OnboardModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _OnboardSlide extends StatelessWidget {
  final _OnboardModel model;

  const _OnboardSlide({required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const Spacer(),
        // Illustration circle
        Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primarySoft,
          ),
          child: Center(
            child: Icon(
              model.icon,
              size: 120,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 12),
        Text(
          model.description,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
