import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPengembalianMaterial extends StatefulWidget {
  const FormPengembalianMaterial({super.key});

  @override
  _FormPengembalianMaterialState createState() =>
      _FormPengembalianMaterialState();
}

class _FormPengembalianMaterialState extends State<FormPengembalianMaterial> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
  final TextEditingController _penerimaController = TextEditingController();
  final TextEditingController _penyerahController = TextEditingController();
  final TextEditingController _noDokumenController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  DateTime? _tanggal;

  String _kondisi = 'Baik'; // Default condition

  @override
  void initState() {
    super.initState();
    _generateDefaultNoDokumen(); // Generate default document number
  }

  void _generateDefaultNoDokumen() {
    String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
    _noDokumenController.text =
        'RET-$formattedDate'; // Set default document number
  }

  @override
  void dispose() {
    _materialController.dispose();
    _jumlahController.dispose();
    _satuanController.dispose();
    _penerimaController.dispose();
    _penyerahController.dispose();
    _noDokumenController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _tanggal) {
      setState(() {
        _tanggal = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Simpan data pengembalian material
      // TODO: Implementasi penyimpanan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengembalian material berhasil disimpan!'),
        ),
      );
      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _tanggal = null;
        _kondisi = 'Baik'; // Reset kondisi ke default
        _generateDefaultNoDokumen(); // Regenerate document number
      });
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case 'Baik':
        return Colors.green;
      case 'Rusak <10%':
        return Colors.yellowAccent;
      case 'Rusak 10-30%':
        return Colors.orange.shade700;
      case 'Rusak >30%':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pengembalian Material'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _materialController,
                    decoration: const InputDecoration(
                      labelText: 'Material',
                      prefixIcon: Icon(Icons.inventory),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap masukkan nama material';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jumlahController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah',
                      prefixIcon: Icon(Icons.format_list_numbered),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap masukkan jumlah';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _satuanController,
                    decoration: const InputDecoration(
                      labelText: 'Satuan',
                      prefixIcon: Icon(Icons.scale),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap masukkan satuan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _kondisi,
                    decoration: const InputDecoration(
                      labelText: 'Kondisi',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        [
                          'Baik',
                          'Rusak <10%',
                          'Rusak 10-30%',
                          'Rusak >30%',
                        ].map((String condition) {
                          return DropdownMenuItem<String>(
                            value: condition,
                            child: Text(condition),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _kondisi = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _penerimaController,
                    decoration: const InputDecoration(
                      labelText: 'Penerima',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _penyerahController,
                    decoration: const InputDecoration(
                      labelText: 'Penyerah',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _noDokumenController,
                    decoration: const InputDecoration(
                      labelText: 'No. Dokumen',
                      prefixIcon: Icon(Icons.document_scanner),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Make this field read-only
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _keteranganController,
                    decoration: const InputDecoration(
                      labelText: 'Keterangan',
                      prefixIcon: Icon(Icons.note),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _tanggal == null
                            ? 'Tanggal: Belum dipilih'
                            : 'Tanggal: ${DateFormat('dd MMM yyyy').format(_tanggal!)}',
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: const Text(
                          'Pilih Tanggal',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Simpan', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
