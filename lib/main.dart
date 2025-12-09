import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'core/supabase_client.dart';
import 'core/theme.dart';
import 'core/notification_service.dart';
import 'modules/auth/login_page.dart';
import 'modules/auth/register_page.dart';
import 'modules/home/home_page.dart';
import 'modules/onboarding/onboarding_page.dart';
import 'modules/order/order_address_page.dart';
import 'modules/order/order_service_page.dart';
import 'modules/order/order_success_page.dart';
import 'modules/order/order_summary_page.dart';
import 'modules/profile/profile_page.dart';
import 'modules/splash/splash_page.dart';
import 'modules/tracking/tracking_page.dart';
import 'modules/notifications/notifications_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseClientManager.init();
  await NotificationService.init();
  runApp(const JoySpinApp());
}

class JoySpinApp extends StatelessWidget {
  const JoySpinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JoySpin Laundry',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstants.routeSplash,
      routes: {
        AppConstants.routeSplash: (_) => const SplashPage(),
        AppConstants.routeOnboarding: (_) => const OnboardingPage(),
        AppConstants.routeLogin: (_) => const LoginPage(),
        AppConstants.routeRegister: (_) => const RegisterPage(),
        AppConstants.routeHome: (_) => const HomePage(),
        AppConstants.routeOrderService: (_) => const OrderServicePage(),
        AppConstants.routeOrderAddress: (_) => const OrderAddressPage(),
        AppConstants.routeOrderSummary: (_) => const OrderSummaryPage(),
        AppConstants.routeOrderSuccess: (_) => const OrderSuccessPage(),
        AppConstants.routeTracking: (_) => const TrackingPage(),
        AppConstants.routeProfile: (_) => const ProfilePage(),
        AppConstants.routeNotifications: (_) => const NotificationsPage(),
      },
    );
  }
}
