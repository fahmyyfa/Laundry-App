import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../data/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  bool _loading = false;
  final _authService = AuthService();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await _authService.signUp(
        email: _emailC.text.trim(),
        password: _passwordC.text.trim(),
        fullName: _nameC.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppConstants.routeHome,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Register gagal: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameC,
                decoration: const InputDecoration(labelText: 'Nama lengkap'),
                validator: (v) =>
                    v != null && v.isNotEmpty ? null : 'Wajib diisi',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailC,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v != null && v.contains('@') ? null : 'Email tidak valid',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordC,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (v) =>
                    v != null && v.length >= 6 ? null : 'Min 6 karakter',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  child: Text(_loading ? 'Memproses...' : 'Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
