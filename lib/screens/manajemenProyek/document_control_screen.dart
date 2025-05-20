import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class DocumentControlScreen extends StatelessWidget {
  const DocumentControlScreen({Key? key}) : super(key: key);

  final Map<String, List<Map<String, String>>> _dokumenPerProyek = const {
    'Proyek Gedung Serbaguna A': [
      {
        'judul': 'Gambar Arsitektur',
        'tipe': 'PDF',
        'status': 'Terverifikasi',
        'tanggal': '10 Mei 2025',
      },
      {
        'judul': 'RAB Awal',
        'tipe': 'Excel',
        'status': 'Revisi',
        'tanggal': '08 Mei 2025',
      },
    ],
    'Pembangunan Jalan Tol B': [
      {
        'judul': 'Laporan Konstruksi',
        'tipe': 'DOCX',
        'status': 'Menunggu',
        'tanggal': '11 Mei 2025',
      },
      {
        'judul': 'Foto Progress',
        'tipe': 'Image',
        'status': 'Terverifikasi',
        'tanggal': '09 Mei 2025',
      },
    ],
    'Penerangan Desa C': [
      {
        'judul': 'Dokumen Perencanaan',
        'tipe': 'PDF',
        'status': 'Menunggu',
        'tanggal': '12 Mei 2025',
      },
    ],
  };

  IconData _getIconForType(String tipe) {
    switch (tipe.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
        return Icons.description;
      case 'excel':
        return Icons.table_chart;
      case 'image':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'terverifikasi':
        return Colors.green;
      case 'menunggu':
        return Colors.orange;
      case 'revisi':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kontrol Dokumen per Proyek'),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children:
            _dokumenPerProyek.entries.map((entry) {
              final proyek = entry.key;
              final dokumenList = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proyek,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...dokumenList.map((dok) {
                    final icon = _getIconForType(dok['tipe']!);
                    final statusColor = _getStatusColor(dok['status']!);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: statusColor.withOpacity(0.15),
                          child: Icon(icon, color: statusColor),
                        ),
                        title: Text(
                          dok['judul']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Tanggal: ${dok['tanggal']}'),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: statusColor),
                          ),
                          child: Text(
                            dok['status']!,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Buka dokumen: ${dok['judul']}'),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tambah dokumen baru')));
        },
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.upload_file),
        label: const Text('Unggah Dokumen'),
      ),
    );
  }
}
