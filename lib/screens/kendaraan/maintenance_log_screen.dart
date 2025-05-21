import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class MaintenanceLogScreen extends StatefulWidget {
  const MaintenanceLogScreen({super.key});

  @override
  State<MaintenanceLogScreen> createState() => _MaintenanceLogScreenState();
}

class _MaintenanceLogScreenState extends State<MaintenanceLogScreen> {
  final List<Map<String, dynamic>> _jadwalServis = [];

  void _tambahJadwalServis() {
    String? selectedKendaraan;
    String jenisServis = 'Harian';
    final deskripsiController = TextEditingController();
    DateTime tanggalServis = DateTime.now();

    final List<String> kendaraanList = [
      'Excavator PC200-8',
      'Toyota Avanza',
      'Dump Truck Hino',
      'Forklift Diesel',
    ];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Jadwal Servis'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedKendaraan,
                    hint: const Text('Pilih Kendaraan'),
                    items:
                        kendaraanList.map((k) {
                          return DropdownMenuItem(value: k, child: Text(k));
                        }).toList(),
                    onChanged: (val) => selectedKendaraan = val,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: jenisServis,
                    items:
                        ['Harian', 'Bulanan']
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                    onChanged: (val) {
                      if (val != null) jenisServis = val;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Jenis Servis',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 8),
                      Text(DateFormat('dd-MM-yyyy').format(tanggalServis)),
                      IconButton(
                        icon: const Icon(Icons.edit_calendar),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tanggalServis,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => tanggalServis = picked);
                          }
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(
                      labelText: 'Catatan/Deskripsi',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedKendaraan != null) {
                    setState(() {
                      _jadwalServis.add({
                        'kendaraan': selectedKendaraan,
                        'jenis': jenisServis,
                        'tanggal': tanggalServis,
                        'catatan': deskripsiController.text,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  Color _getColorForDate(DateTime tgl) {
    if (tgl.isBefore(DateTime.now())) return Colors.red.shade100;
    if (tgl.difference(DateTime.now()).inDays <= 2)
      return Colors.orange.shade100;
    return Colors.green.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Daftar Kendaraan & Alat'),

      body:
          _jadwalServis.isEmpty
              ? const Center(child: Text('Belum ada jadwal servis.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _jadwalServis.length,
                itemBuilder: (context, index) {
                  final item = _jadwalServis[index];
                  final tgl = item['tanggal'] as DateTime;
                  return Card(
                    color: _getColorForDate(tgl),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(
                        item['jenis'] == 'Harian'
                            ? Icons.calendar_view_day
                            : Icons.calendar_month,
                        color: Colors.blue,
                        size: 32,
                      ),
                      title: Text('${item['kendaraan']} (${item['jenis']})'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal Servis: ${DateFormat('dd-MM-yyyy').format(tgl)}',
                          ),
                          if (item['catatan'].toString().isNotEmpty)
                            Text('Catatan: ${item['catatan']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwalServis,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
