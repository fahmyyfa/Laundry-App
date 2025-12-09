import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final t = await FirebaseMessaging.instance.getToken();
    setState(() => _token = t);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifikasi Push',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jika integrasi Firebase sudah benar, kamu bisa menerima notifikasi FCM di aplikasi ini.',
            ),
            const SizedBox(height: 16),
            const Text('Token FCM (untuk testing dengan FCM console):'),
            const SizedBox(height: 8),
            SelectableText(_token ?? 'Memuat token...'),
          ],
        ),
      ),
    );
  }
}
