import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class FuelMonitoringScreen extends StatefulWidget {
  const FuelMonitoringScreen({super.key});

  @override
  State<FuelMonitoringScreen> createState() => _FuelMonitoringScreenState();
}

class _FuelMonitoringScreenState extends State<FuelMonitoringScreen> {
  final List<Map<String, dynamic>> _fuelLogs = [];

  final List<String> kendaraanList = [
    'Mobil Operasional A',
    'Excavator 01',
    'Dump Truck 03',
  ];

  final List<String> proyekList = [
    'Proyek Jalan Tol Cisumdawu',
    'Proyek Bendungan Batang Toru',
    'Proyek Gedung Kantor Pusat',
  ];

  void _showAddLogDialog() {
    String? selectedKendaraan;
    String? selectedProyek;
    final literController = TextEditingController();
    final biayaController = TextEditingController();
    final catatanController = TextEditingController();
    DateTime tanggal = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Log BBM & Biaya'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedProyek,
                  hint: const Text('Pilih Proyek'),
                  items:
                      proyekList
                          .map(
                            (p) => DropdownMenuItem(value: p, child: Text(p)),
                          )
                          .toList(),
                  onChanged: (val) => selectedProyek = val,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedKendaraan,
                  hint: const Text('Pilih Kendaraan'),
                  items:
                      kendaraanList
                          .map(
                            (k) => DropdownMenuItem(value: k, child: Text(k)),
                          )
                          .toList(),
                  onChanged: (val) => selectedKendaraan = val,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: literController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Liter BBM',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: biayaController,
                  decoration: const InputDecoration(labelText: 'Biaya (Rp)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: catatanController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (opsional)',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(DateFormat('dd-MM-yyyy').format(tanggal)),
                    IconButton(
                      icon: const Icon(Icons.edit_calendar),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: tanggal,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => tanggal = picked);
                        }
                      },
                    ),
                  ],
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
                if (selectedKendaraan != null &&
                    selectedProyek != null &&
                    literController.text.isNotEmpty &&
                    biayaController.text.isNotEmpty) {
                  setState(() {
                    _fuelLogs.add({
                      'proyek': selectedProyek,
                      'kendaraan': selectedKendaraan,
                      'tanggal': tanggal,
                      'liter': double.tryParse(literController.text) ?? 0,
                      'biaya': double.tryParse(biayaController.text) ?? 0,
                      'catatan': catatanController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Daftar Kendaraan & Alat'),
      body:
          _fuelLogs.isEmpty
              ? const Center(child: Text('Belum ada data BBM.'))
              : ListView.builder(
                itemCount: _fuelLogs.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final item = _fuelLogs[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(
                        Icons.local_gas_station,
                        color: Colors.blue,
                      ),
                      title: Text(item['kendaraan']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Proyek: ${item['proyek']}'),
                          Text(
                            'Tanggal: ${DateFormat('dd-MM-yyyy').format(item['tanggal'])}',
                          ),
                          Text('Liter BBM: ${item['liter']}'),
                          Text('Biaya: Rp ${item['biaya'].toStringAsFixed(0)}'),
                          if ((item['catatan'] as String).isNotEmpty)
                            Text('Catatan: ${item['catatan']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLogDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
