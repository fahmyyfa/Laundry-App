import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../data/services/location_service.dart';

class OrderAddressPage extends StatefulWidget {
  const OrderAddressPage({super.key});

  @override
  State<OrderAddressPage> createState() => _OrderAddressPageState();
}

class _OrderAddressPageState extends State<OrderAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressC = TextEditingController();
  String? _locationInfo;
  bool _locLoading = false;

  Future<void> _useCurrentLocation() async {
    setState(() {
      _locLoading = true;
      _locationInfo = null;
    });
    final pos = await LocationService.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      _locLoading = false;
      if (pos != null) {
        _locationInfo = 'Lat: ${pos.latitude}, Lng: ${pos.longitude}';
      } else {
        _locationInfo = 'Lokasi tidak dapat diambil';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Pengambilan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _addressC,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Alamat lengkap'),
                validator: (v) =>
                    v != null && v.isNotEmpty ? null : 'Alamat wajib diisi',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _locLoading ? null : _useCurrentLocation,
                    icon: const Icon(Icons.my_location),
                    label: Text(
                      _locLoading
                          ? 'Mengambil lokasi...'
                          : 'Gunakan Lokasi Saat Ini',
                    ),
                  ),
                ],
              ),
              if (_locationInfo != null) ...[
                const SizedBox(height: 8),
                Text(
                  _locationInfo!,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    Navigator.pushNamed(
                      context,
                      AppConstants.routeOrderSummary,
                      arguments: {...args, 'address': _addressC.text.trim()},
                    );
                  },
                  child: const Text('Lanjut ke Ringkasan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
