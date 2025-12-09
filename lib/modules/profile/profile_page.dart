import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil Saya')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                (user?.userMetadata?['full_name'] ?? 'U')[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              user?.userMetadata?['full_name'] ?? 'Pengguna',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(user?.email ?? ''),
            const SizedBox(height: 32),
            const ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Alamat tersimpan (bisa dikembangkan).'),
            ),
            const ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text('Preferensi notifikasi (opsional).'),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                await auth.signOut();
                if (context.mounted) Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
