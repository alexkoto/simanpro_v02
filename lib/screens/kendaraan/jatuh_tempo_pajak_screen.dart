import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PajakPerizinanScreen extends StatefulWidget {
  const PajakPerizinanScreen({super.key});

  @override
  State<PajakPerizinanScreen> createState() => _PajakPerizinanScreenState();
}

class _PajakPerizinanScreenState extends State<PajakPerizinanScreen> {
  final List<Map<String, dynamic>> _dataPajak = [
    {
      'jenis': 'Pajak Tahunan',
      'noPol': 'BM 1234 CD',
      'tipe': 'Mobil Operasional',
      'terakhir': DateTime(2024, 5, 10),
      'berikutnya': DateTime(2025, 5, 10),
    },
    {
      'jenis': 'KIR',
      'noPol': 'BM 5678 EF',
      'tipe': 'Pickup',
      'terakhir': DateTime(2024, 8, 12),
      'berikutnya': DateTime(2025, 8, 12),
    },
  ];

  String? _selectedJenis;
  final _noPolController = TextEditingController();
  final _tipeController = TextEditingController();
  DateTime? _tglTerakhir;
  DateTime? _tglBerikutnya;

  final List<String> _jenisList = [
    'Pajak Tahunan',
    'KIR',
    'STNK',
    'Asuransi',
    'Izin Trayek',
  ];

  void _editTanggal(int index, String tipeTanggal) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataPajak[index][tipeTanggal],
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dataPajak[index][tipeTanggal] = picked;
      });
    }
  }

  void _showTambahDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Data Pajak / Perizinan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Pajak / KIR',
                  ),
                  value: _selectedJenis,
                  items:
                      _jenisList.map((jenis) {
                        return DropdownMenuItem(
                          value: jenis,
                          child: Text(jenis),
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedJenis = val;
                    });
                  },
                ),
                TextField(
                  controller: _noPolController,
                  decoration: const InputDecoration(labelText: 'No. Polisi'),
                ),
                TextField(
                  controller: _tipeController,
                  decoration: const InputDecoration(
                    labelText: 'Tipe Kendaraan',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Tanggal Bayar Terakhir:'),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => _tglTerakhir = picked);
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Jatuh Tempo Berikutnya:'),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => _tglBerikutnya = picked);
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
                if (_selectedJenis != null &&
                    _noPolController.text.isNotEmpty &&
                    _tipeController.text.isNotEmpty &&
                    _tglTerakhir != null &&
                    _tglBerikutnya != null) {
                  setState(() {
                    _dataPajak.add({
                      'jenis': _selectedJenis!,
                      'noPol': _noPolController.text,
                      'tipe': _tipeController.text,
                      'terakhir': _tglTerakhir!,
                      'berikutnya': _tglBerikutnya!,
                    });
                  });
                  _selectedJenis = null;
                  _noPolController.clear();
                  _tipeController.clear();
                  _tglTerakhir = null;
                  _tglBerikutnya = null;
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
      appBar: AppBar(title: const Text('Jatuh Tempo Pajak & Perizinan')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Jenis')),
            DataColumn(label: Text('No. Polisi')),
            DataColumn(label: Text('Tipe Kendaraan')),
            DataColumn(label: Text('Terakhir Bayar')),
            DataColumn(label: Text('Jatuh Tempo')),
            DataColumn(label: Text('Aksi')),
          ],
          rows: List.generate(_dataPajak.length, (index) {
            final item = _dataPajak[index];
            return DataRow(
              cells: [
                DataCell(Text(item['jenis'])),
                DataCell(Text(item['noPol'])),
                DataCell(Text(item['tipe'])),
                DataCell(
                  Text(DateFormat('dd-MM-yyyy').format(item['terakhir'])),
                ),
                DataCell(
                  Text(DateFormat('dd-MM-yyyy').format(item['berikutnya'])),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_calendar),
                        onPressed: () => _editTanggal(index, 'terakhir'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.event_repeat),
                        onPressed: () => _editTanggal(index, 'berikutnya'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
