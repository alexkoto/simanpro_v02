import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class LaporanInsidenScreen extends StatefulWidget {
  const LaporanInsidenScreen({super.key});

  @override
  State<LaporanInsidenScreen> createState() => _LaporanInsidenScreenState();
}

class _LaporanInsidenScreenState extends State<LaporanInsidenScreen> {
  final List<Map<String, dynamic>> _laporanList = [];

  void _showAddInsidenDialog() {
    final lokasiController = TextEditingController();
    final deskripsiController = TextEditingController();
    final tindakanController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String tingkatKeparahan = 'Ringan';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Tambah Laporan Insiden'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: lokasiController,
                      decoration: const InputDecoration(labelText: 'Lokasi'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                        IconButton(
                          icon: const Icon(Icons.edit_calendar),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setModalState(() => selectedDate = picked);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: tingkatKeparahan,
                      decoration: const InputDecoration(
                        labelText: 'Tingkat Keparahan',
                      ),
                      items: ['Ringan', 'Sedang', 'Berat']
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setModalState(() => tingkatKeparahan = value);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: deskripsiController,
                      decoration:
                          const InputDecoration(labelText: 'Deskripsi Insiden'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: tindakanController,
                      decoration:
                          const InputDecoration(labelText: 'Tindakan Diperlukan'),
                      maxLines: 2,
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
                    if (lokasiController.text.isNotEmpty &&
                        deskripsiController.text.isNotEmpty) {
                      setState(() {
                        _laporanList.add({
                          'tanggal': selectedDate,
                          'lokasi': lokasiController.text,
                          'deskripsi': deskripsiController.text,
                          'keparahan': tingkatKeparahan,
                          'tindakan': tindakanController.text,
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
      },
    );
  }

  Color _getSeverityColor(String tingkat) {
    switch (tingkat) {
      case 'Berat':
        return Colors.red.shade200;
      case 'Sedang':
        return Colors.orange.shade200;
      default:
        return Colors.green.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Laporan Insiden'),
      body: _laporanList.isEmpty
          ? const Center(child: Text('Belum ada laporan insiden.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _laporanList.length,
              itemBuilder: (context, index) {
                final item = _laporanList[index];
                return Card(
                  color: _getSeverityColor(item['keparahan']),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded),
                            const SizedBox(width: 8),
                            Text(
                              item['lokasi'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(item['tanggal']),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text('Keparahan: ${item['keparahan']}'),
                        const SizedBox(height: 6),
                        Text('Deskripsi: ${item['deskripsi']}'),
                        const SizedBox(height: 6),
                        Text('Tindakan: ${item['tindakan']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInsidenDialog,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
