import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service untuk inisialisasi Firebase + notifikasi lokal.
/// BUTUH:
/// - Project Firebase sudah dibuat
/// - google-services.json (Android) sudah terpasang
class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Inisialisasi Firebase
    await Firebase.initializeApp();

    // Request izin notifikasi (khusus iOS / Android 13+)
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    // Inisialisasi plugin lokal notif
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotif.initialize(initSettings);

    // Channel Android untuk notif
    const androidChannel = AndroidNotificationChannel(
      'joyspin_channel',
      'JoySpin Notifications',
      description: 'Notifikasi status pesanan & promo',
      importance: Importance.high,
    );

    await _localNotif
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    // Listener pesan ketika app foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Dapatkan token FCM (bisa kamu simpan ke Supabase untuk backend)
    final token = await _fcm.getToken();
    debugPrint('FCM TOKEN: $token');
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'joyspin_channel',
      'JoySpin Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotif.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
    );
  }
}
