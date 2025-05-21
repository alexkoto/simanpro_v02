import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressBillingScreen extends StatefulWidget {
  const ProgressBillingScreen({super.key});

  @override
  State<ProgressBillingScreen> createState() => _ProgressBillingScreenState();
}

class _ProgressBillingScreenState extends State<ProgressBillingScreen> {
  final List<Map<String, dynamic>> _billingList = [
    {
      'proyek': 'Gedung A',
      'termin': 'Termin 1',
      'nilai': 50000000,
      'tanggal': DateTime(2024, 5, 1),
      'status': 'Belum Dibayar',
    },
    {
      'proyek': 'Jalan Raya X',
      'termin': 'Termin 2',
      'nilai': 75000000,
      'tanggal': DateTime(2024, 6, 15),
      'status': 'Sudah Dibayar',
    },
  ];

  final List<String> _proyekList = ['Gedung A', 'Jalan Raya X', 'Pabrik Y'];
  final List<String> _terminList = ['Termin 1', 'Termin 2', 'Termin 3'];

  String? _selectedProyek;
  String? _selectedTermin;
  final _nilaiController = TextEditingController();
  DateTime? _tanggal;
  String _status = 'Belum Dibayar';

  void _showTambahDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Progress Billing'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Nama Proyek'),
                  value: _selectedProyek,
                  items:
                      _proyekList.map((proyek) {
                        return DropdownMenuItem(
                          value: proyek,
                          child: Text(proyek),
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedProyek = val;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Termin'),
                  value: _selectedTermin,
                  items:
                      _terminList.map((termin) {
                        return DropdownMenuItem(
                          value: termin,
                          child: Text(termin),
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedTermin = val;
                    });
                  },
                ),
                TextField(
                  controller: _nilaiController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Nilai (Rp)'),
                ),
                Row(
                  children: [
                    const Text('Tanggal: '),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() => _tanggal = picked);
                        }
                      },
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Status'),
                  value: _status,
                  items:
                      ['Belum Dibayar', 'Sudah Dibayar'].map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _status = val;
                      });
                    }
                  },
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
                if (_selectedProyek != null &&
                    _selectedTermin != null &&
                    _nilaiController.text.isNotEmpty &&
                    _tanggal != null) {
                  setState(() {
                    _billingList.add({
                      'proyek': _selectedProyek!,
                      'termin': _selectedTermin!,
                      'nilai': int.tryParse(_nilaiController.text) ?? 0,
                      'tanggal': _tanggal!,
                      'status': _status,
                    });
                  });
                  _selectedProyek = null;
                  _selectedTermin = null;
                  _nilaiController.clear();
                  _tanggal = null;
                  _status = 'Belum Dibayar';
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
      appBar: AppBar(title: const Text('Progress Billing')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Proyek')),
            DataColumn(label: Text('Termin')),
            DataColumn(label: Text('Nilai')),
            DataColumn(label: Text('Tanggal')),
            DataColumn(label: Text('Status')),
          ],
          rows:
              _billingList.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item['proyek'])),
                    DataCell(Text(item['termin'])),
                    DataCell(
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                        ).format(item['nilai']),
                      ),
                    ),
                    DataCell(
                      Text(DateFormat('dd-MM-yyyy').format(item['tanggal'])),
                    ),
                    DataCell(Text(item['status'])),
                  ],
                );
              }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
