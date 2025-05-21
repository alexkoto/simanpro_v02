import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class InspeksiHarianScreen extends StatefulWidget {
  const InspeksiHarianScreen({super.key});

  @override
  State<InspeksiHarianScreen> createState() => _InspeksiHarianScreenState();
}

class _InspeksiHarianScreenState extends State<InspeksiHarianScreen> {
  final List<Map<String, dynamic>> _inspeksiList = [];

  void _showAddInspeksiDialog() {
    final lokasiController = TextEditingController();
    final catatanController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String status = 'Aman';
    String potensiBahaya = 'Tidak Ada';
    String workingPermit = 'Tidak Ada';

    // APD
    bool apdHelm = false;
    bool apdSepatu = false;
    bool apdRompi = false;
    bool apdHarness = false;
    bool apdKacamata = false;
    bool apdSarungTangan = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Tambah Inspeksi Harian'),
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
                    const Divider(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pemeriksaan APD:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('Helm'),
                      value: apdHelm,
                      onChanged: (val) => setModalState(() => apdHelm = val!),
                    ),
                    CheckboxListTile(
                      title: const Text('Sepatu'),
                      value: apdSepatu,
                      onChanged: (val) => setModalState(() => apdSepatu = val!),
                    ),
                    CheckboxListTile(
                      title: const Text('Rompi'),
                      value: apdRompi,
                      onChanged: (val) => setModalState(() => apdRompi = val!),
                    ),
                    CheckboxListTile(
                      title: const Text('Fullbody Harness'),
                      value: apdHarness,
                      onChanged:
                          (val) => setModalState(() => apdHarness = val!),
                    ),
                    CheckboxListTile(
                      title: const Text('Kacamata'),
                      value: apdKacamata,
                      onChanged:
                          (val) => setModalState(() => apdKacamata = val!),
                    ),
                    CheckboxListTile(
                      title: const Text('Sarung Tangan'),
                      value: apdSarungTangan,
                      onChanged:
                          (val) => setModalState(() => apdSarungTangan = val!),
                    ),
                    const Divider(),
                    DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(
                        labelText: 'Status Umum',
                      ),
                      items:
                          ['Aman', 'Perlu Tindakan', 'Bahaya']
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (val) {
                        if (val != null) setModalState(() => status = val);
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: potensiBahaya,
                      decoration: const InputDecoration(
                        labelText: 'Potensi Bahaya',
                      ),
                      items:
                          [
                                'Tidak Ada',
                                'Listrik',
                                'Ketinggian',
                                'Material Tajam',
                              ]
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (val) {
                        if (val != null)
                          setModalState(() => potensiBahaya = val);
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: workingPermit,
                      decoration: const InputDecoration(
                        labelText: 'Working Permit',
                      ),
                      items:
                          ['Tidak Ada', 'Ada']
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (val) {
                        if (val != null)
                          setModalState(() => workingPermit = val);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: catatanController,
                      decoration: const InputDecoration(labelText: 'Catatan'),
                      maxLines: 3,
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
                    if (lokasiController.text.isNotEmpty) {
                      setState(() {
                        _inspeksiList.add({
                          'tanggal': selectedDate,
                          'lokasi': lokasiController.text,
                          'helm': apdHelm,
                          'sepatu': apdSepatu,
                          'rompi': apdRompi,
                          'harness': apdHarness,
                          'kacamata': apdKacamata,
                          'sarungTangan': apdSarungTangan,
                          'status': status,
                          'potensiBahaya': potensiBahaya,
                          'workingPermit': workingPermit,
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
      },
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'Bahaya':
        return const Icon(Icons.warning, color: Colors.red);
      case 'Perlu Tindakan':
        return const Icon(Icons.report_problem, color: Colors.orange);
      default:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inspeksi Harian'),
      body:
          _inspeksiList.isEmpty
              ? const Center(child: Text('Belum ada data inspeksi.'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _inspeksiList.length,
                itemBuilder: (context, index) {
                  final item = _inspeksiList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _getStatusIcon(item['status']),
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
                                DateFormat(
                                  'dd-MM-yyyy',
                                ).format(item['tanggal']),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _buildApdChip('Helm', item['helm']),
                              _buildApdChip('Sepatu', item['sepatu']),
                              _buildApdChip('Rompi', item['rompi']),
                              _buildApdChip('Harness', item['harness']),
                              _buildApdChip('Kacamata', item['kacamata']),
                              _buildApdChip(
                                'Sarung Tangan',
                                item['sarungTangan'],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Potensi Bahaya: ${item['potensiBahaya']}'),
                          Text('Working Permit: ${item['workingPermit']}'),
                          Text('Status Umum: ${item['status']}'),
                          Text('Catatan: ${item['catatan']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInspeksiDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildApdChip(String label, bool checked) {
    return Chip(
      label: Text('$label: ${checked ? "✓" : "✗"}'),
      backgroundColor: checked ? Colors.green.shade100 : Colors.red.shade100,
    );
  }
}
