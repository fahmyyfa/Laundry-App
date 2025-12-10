import 'dart:async';

import 'package:flutter/material.dart';
import 'package:joyspin_laundry/core/constants.dart';
import 'package:joyspin_laundry/core/theme.dart';
import 'package:joyspin_laundry/supabase_client.dart';
import 'package:joyspin_laundry/notification_service.dart';

// PAGES
import 'package:joyspin_laundry/modules/splash/splash_page.dart';
import 'package:joyspin_laundry/modules/onboarding/onboarding_page.dart';
import 'package:joyspin_laundry/modules/auth/login_page.dart';
import 'package:joyspin_laundry/modules/auth/register_page.dart';
import 'package:joyspin_laundry/modules/home/home_page.dart';
import 'package:joyspin_laundry/modules/order/order_service_page.dart';
import 'package:joyspin_laundry/modules/order/order_address_page.dart';
import 'package:joyspin_laundry/modules/order/order_summary_page.dart';
import 'package:joyspin_laundry/modules/order/order_success_page.dart';
import 'package:joyspin_laundry/modules/tracking/tracking_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase (kalau gagal, app tetap jalan)
  try {
    await SupabaseClientProvider.init(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  } catch (e, st) {
    // Jangan matikan app kalau Supabase gagal
    debugPrint('Supabase init ERROR: $e');
    debugPrint('$st');
  }

  // Inisialisasi notifikasi lokal (flutter_local_notifications)
  await NotificationService.instance.init();

  runApp(const JoySpinApp());
}

class JoySpinApp extends StatelessWidget {
  const JoySpinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JoySpin Laundry',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      // Alur awal: splash -> onboarding -> login -> home
      initialRoute: AppConstants.routeSplash,

      routes: {
        // Splash & onboarding
        AppConstants.routeSplash: (_) => const SplashPage(),
        AppConstants.routeOnboarding: (_) => const OnboardingPage(),

        // Auth
        AppConstants.routeLogin: (_) => const LoginPage(),
        AppConstants.routeRegister: (_) => const RegisterPage(),

        // Home
        AppConstants.routeHome: (_) => const HomePage(),

        // Flow pesanan
        AppConstants.routeOrderNew: (_) => const OrderServicePage(),
        AppConstants.routeOrderAddress: (_) => const OrderAddressPage(),
        AppConstants.routeOrderSummary: (_) => const OrderSummaryPage(),
        AppConstants.routeOrderSuccess: (_) => const OrderSuccessPage(),

        // Tracking
        AppConstants.routeTracking: (_) => const TrackingPage(),
      },
    );
  }
}
