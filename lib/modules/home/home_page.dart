import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/theme.dart';
import '../../data/models/service.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/service_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _serviceService = ServiceService();
  final _authService = AuthService();
  late Future<List<Service>> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _servicesFuture = _serviceService.fetchServices();
  }

  Future<void> _logout() async {
    await _authService.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppConstants.routeLogin,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('JoySpin Laundry'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppConstants.routeNotifications),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppConstants.routeProfile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.userMetadata?['full_name'] ?? 'Pengguna'),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: AppTheme.primaryBlue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _servicesFuture = _serviceService.fetchServices());
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Halo, ${user?.userMetadata?['full_name'] ?? 'JoySpinner'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Pilih layanan laundry yang kamu butuhkan:',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            FutureBuilder<List<Service>>(
              future: _servicesFuture,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snap.hasError) {
                  return Text('Error: ${snap.error}');
                }
                final services = snap.data ?? [];
                if (services.isEmpty) {
                  return const Text('Belum ada layanan.');
                }
                return Column(
                  children: services
                      .map(
                        (s) => GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppConstants.routeOrderService,
                            arguments: s,
                          ),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.local_laundry_service,
                                color: AppTheme.primaryBlue,
                              ),
                              title: Text(s.name),
                              subtitle: Text(s.description),
                              trailing: Text(
                                'Mulai\nRp ${s.basePrice}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
