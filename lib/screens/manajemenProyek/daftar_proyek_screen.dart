import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class DaftarProyekScreen extends StatelessWidget {
  const DaftarProyekScreen({Key? key}) : super(key: key);

  // Contoh data proyek statis. Nantinya bisa diganti dengan data dari API atau database.
  final List<Map<String, String>> daftarProyek = const [
    {
      'nama': 'Proyek A',
      'lokasi': 'Jakarta',
      'status': 'Berjalan',
      'tanggalMulai': '01 Januari 2025',
    },
    {
      'nama': 'Proyek B',
      'lokasi': 'Bandung',
      'status': 'Selesai',
      'tanggalMulai': '15 Februari 2025',
    },
    {
      'nama': 'Proyek C',
      'lokasi': 'Surabaya',
      'status': 'Perencanaan',
      'tanggalMulai': '20 Maret 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Daftar Proyek'),
      body: ListView.builder(
        itemCount: daftarProyek.length,
        itemBuilder: (context, index) {
          final proyek = daftarProyek[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                proyek['nama']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('Lokasi: ${proyek['lokasi']}'),
                  Text('Status: ${proyek['status']}'),
                  Text('Mulai: ${proyek['tanggalMulai']}'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Tambahkan navigasi ke detail proyek
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Klik: ${proyek['nama']}')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Tambahkan aksi tambah proyek
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tambah proyek baru')));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
