import 'package:flutter/material.dart';

/// Semua konstanta global aplikasi
class AppConstants {
  // ================== ROUTES ==================
  static const routeSplash = '/splash';
  static const routeOnboarding = '/onboarding';

  static const routeLogin = '/login';
  static const routeRegister = '/register';

  static const routeHome = '/home';

  // Flow pesanan
  static const routeOrderNew = '/order/new';
  static const routeOrderAddress = '/order/address';
  static const routeOrderSummary = '/order/summary';
  static const routeOrderSuccess = '/order/success';

  // Tracking
  static const routeTracking = '/tracking';

  // ================== SUPABASE ==================
  // TODO: ganti dengan URL & anon key Supabase milikmu
  static const supabaseUrl = 'https://nknchcnywzhdocyblewx.supabase.co';
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5rbmNoY255d3poZG9jeWJsZXd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUyNzEzOTMsImV4cCI6MjA4MDg0NzM5M30.V_c6AxrtT2JhI8Y6uGNNi9IoUax5Re4OKrYNNYqhYfo';
}

/// Palet warna utama aplikasi
class AppColors {
  static const primary = Color(0xFF2F6BFF);
  static const primarySoft = Color(0xFFE1EBFF);

  static const surface = Color(0xFFF5F7FB);

  static const textMain = Color(0xFF1B1D28);
  static const textSecondary = Color(0xFF777A8F);

  static const accent = Color(0xFF0FB57D);
  static const danger = Color(0xFFEB5757);
}
