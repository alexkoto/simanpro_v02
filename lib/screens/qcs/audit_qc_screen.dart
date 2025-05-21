import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:simanpro_v02/components/custom_appbar.dart';

class AuditQCScreen extends StatefulWidget {
  const AuditQCScreen({super.key});

  @override
  State<AuditQCScreen> createState() => _AuditQCScreenState();
}

class _AuditQCScreenState extends State<AuditQCScreen> {
  final List<Map<String, dynamic>> _auditList = [];

  DateTime? _filterDate;
  String _filterHasil = 'Semua';

  void _showAddAuditDialog() {
    final lokasiController = TextEditingController();
    final catatanController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String hasil = 'Sesuai';
    File? fotoTemuan;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Tambah Audit QC'),
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
                      value: hasil,
                      decoration: const InputDecoration(
                        labelText: 'Hasil Audit',
                      ),
                      items:
                          ['Sesuai', 'Tidak Sesuai'].map((s) {
                            return DropdownMenuItem(value: s, child: Text(s));
                          }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setModalState(() => hasil = value);
                        }
                      },
                    ),
                    TextField(
                      controller: catatanController,
                      decoration: const InputDecoration(labelText: 'Catatan'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );
                        if (result != null) {
                          setModalState(() {
                            fotoTemuan = File(result.files.single.path!);
                          });
                        }
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Upload Foto Temuan'),
                    ),
                    if (fotoTemuan != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.file(fotoTemuan!, height: 100),
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
                        _auditList.add({
                          'tanggal': selectedDate,
                          'lokasi': lokasiController.text,
                          'hasil': hasil,
                          'catatan': catatanController.text,
                          'foto': fotoTemuan,
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

  List<Map<String, dynamic>> get _filteredList {
    return _auditList.where((item) {
      if (_filterDate != null &&
          DateFormat('yyyy-MM-dd').format(item['tanggal']) !=
              DateFormat('yyyy-MM-dd').format(_filterDate!)) {
        return false;
      }
      if (_filterHasil != 'Semua' && item['hasil'] != _filterHasil) {
        return false;
      }
      return true;
    }).toList();
  }

  Future<void> _exportToPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build:
            (context) =>
                _filteredList.map((item) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Tanggal: ${DateFormat('dd-MM-yyyy').format(item['tanggal'])}',
                      ),
                      pw.Text('Lokasi: ${item['lokasi']}'),
                      pw.Text('Hasil Audit: ${item['hasil']}'),
                      pw.Text('Catatan: ${item['catatan']}'),
                      pw.SizedBox(height: 10),
                    ],
                  );
                }).toList(),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audit_qc.pdf');
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Audit QC'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _filterHasil,
                    items:
                        ['Semua', 'Sesuai', 'Tidak Sesuai']
                            .map(
                              (val) => DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              ),
                            )
                            .toList(),
                    onChanged: (val) => setState(() => _filterHasil = val!),
                    decoration: const InputDecoration(
                      labelText: 'Filter Hasil',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => _filterDate = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Filter Tanggal',
                      ),
                      child: Text(
                        _filterDate == null
                            ? 'Semua'
                            : DateFormat('dd-MM-yyyy').format(_filterDate!),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  tooltip: 'Ekspor PDF',
                  onPressed: _filteredList.isEmpty ? null : _exportToPdf,
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _filteredList.isEmpty
                    ? const Center(child: Text('Tidak ada data audit.'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _filteredList.length,
                      itemBuilder: (context, index) {
                        final item = _filteredList[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(item['lokasi']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal: ${DateFormat('dd-MM-yyyy').format(item['tanggal'])}',
                                ),
                                Text('Hasil: ${item['hasil']}'),
                                Text('Catatan: ${item['catatan']}'),
                                if (item['foto'] != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Image.file(
                                      item['foto'],
                                      height: 100,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAuditDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
