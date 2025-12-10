import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Delay 2 detik lalu cek apakah user sudah login
    Timer(const Duration(seconds: 2), () {
      // TODO: kalau nanti sudah ada cek token login, arahkan ke home
      // untuk sekarang langsung ke onboarding
      Navigator.pushReplacementNamed(
        context,
        AppConstants.routeOnboarding,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo lingkaran biru
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarySoft,
              ),
              child: const Center(
                child: Icon(
                  Icons.local_laundry_service_rounded,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'JoySpin Laundry',
              style: theme.textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Cepat, rapi, dan wangi ✨',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
