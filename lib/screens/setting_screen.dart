import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notifEnabled = true;
  bool _darkMode = false;

  void _navigateToProfile() {
    // Tambahkan navigasi ke layar profil jika tersedia
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigasi ke Profil belum diimplementasikan'),
      ),
    );
  }

  void _logout() {
    // Tambahkan logika logout di sini
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Arahkan ke login atau splash screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout berhasil')),
                  );
                },
                child: const Text('Keluar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Umum', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: const Text('Notifikasi'),
            value: _notifEnabled,
            onChanged: (val) {
              setState(() => _notifEnabled = val);
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            value: _darkMode,
            onChanged: (val) {
              setState(() => _darkMode = val);
              // Tambahkan logika mode gelap di sini
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),

          const ListTile(
            title: Text('Akun', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil Saya'),
            onTap: _navigateToProfile,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: _logout,
          ),
          const Divider(),

          const ListTile(
            title: Text(
              'Lainnya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            subtitle: const Text('Indonesia'),
            onTap: () {
              // Tambahkan dialog atau navigasi untuk mengganti bahasa
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur bahasa belum tersedia')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Manajemen Proyek',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Perusahaan Anda',
              );
            },
          ),
        ],
      ),
    );
  }
}
