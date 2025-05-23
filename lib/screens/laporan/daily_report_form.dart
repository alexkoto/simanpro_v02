import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DailyReportForm extends StatefulWidget {
  const DailyReportForm({super.key});

  @override
  State<DailyReportForm> createState() => _DailyReportFormState();
}

class _DailyReportFormState extends State<DailyReportForm> {
  final _projectOptions = ['Proyek A', 'Proyek B', 'Proyek C'];
  final _weatherOptions = ['Cerah', 'Berawan', 'Hujan'];
  final _jobOptions = [
    {'name': 'Pemasangan Kabel Listrik', 'unit': 'm'},
    {'name': 'Instalasi Panel Listrik', 'unit': 'unit'},
    {'name': 'Pemasangan Penerangan (Lampu)', 'unit': 'titik'},
    {'name': 'Pemasangan Stop Kontak', 'unit': 'titik'},
    {'name': 'Pemasangan MCB/GFCI', 'unit': 'unit'},
    {'name': 'Pemasangan Grounding System', 'unit': 'titik'},
    {'name': 'Instalasi Kabel Tray', 'unit': 'm'},
    {'name': 'Pemasangan Conduit/Pipa Listrik', 'unit': 'm'},
    {'name': 'Pemasangan Busway', 'unit': 'm'},
    {'name': 'Instalasi Sistem Tenaga', 'unit': 'panel'},
    {'name': 'Pemasangan Genset', 'unit': 'unit'},
    {'name': 'Instalasi ATS (Automatic Transfer Switch)', 'unit': 'unit'},
    {'name': 'Pemasangan PJU (Penerangan Jalan Umum)', 'unit': 'unit'},
    {'name': 'Instalasi Sistem Solar Panel', 'unit': 'kWp'},
    {'name': 'Pemasangan Inverter', 'unit': 'unit'},
    {'name': 'Testing dan Komisioning', 'unit': 'proyek'},
    {'name': 'Troubleshooting Listrik', 'unit': 'jam'},
    {'name': 'Perawatan Gardu Listrik', 'unit': 'unit'},
    {'name': 'Pemasangan Trafo', 'unit': 'unit'},
    {'name': 'Instalasi Sistem Smart Home', 'unit': 'unit'},
    {'name': 'Pemasangan CCTV dan Sistem Keamanan', 'unit': 'titik'},
    {'name': 'Instalasi Sistem Fire Alarm', 'unit': 'titik'},
    {'name': 'Pemasangan Lightning Arrester', 'unit': 'unit'},
    {'name': 'Pengecekan Instalasi (Inspeksi)', 'unit': 'lokasi'},
    {'name': 'Pemasangan Kabel Tegangan Menengah', 'unit': 'm'},
    {'name': 'Pemasangan Tiang Listrik', 'unit': 'unit'},
    {'name': 'Pemasangan Jaringan Fiber Optic', 'unit': 'm'},
    {'name': 'Instalasi Sistem AV (Audio Visual)', 'unit': 'ruangan'},
    {'name': 'Pemasangan Sistem HVAC', 'unit': 'unit'},
    {'name': 'Pemasangan Charging Station', 'unit': 'unit'},
  ];
  final _laborOptions = ['Mandor', 'Tukang', 'Helper'];

  String? _selectedProject;
  String? _selectedWeather;
  final DateTime _selectedDate = DateTime.now();
  final List<Map<String, dynamic>> _jobList = [];
  final List<Map<String, dynamic>> _laborList = [];
  File? _photo;

  void _addJobDialog() {
    String? selectedJob;
    final qtyController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Tambah Pekerjaan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Pekerjaan'),
                  items:
                      _jobOptions.map((job) {
                        return DropdownMenuItem(
                          value: job['name'],
                          child: Text(job['name']!),
                        );
                      }).toList(),
                  onChanged: (val) {
                    selectedJob = val;
                  },
                ),
                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedJob != null && qtyController.text.isNotEmpty) {
                    final jobDetail = _jobOptions.firstWhere(
                      (j) => j['name'] == selectedJob,
                    );
                    setState(() {
                      _jobList.add({
                        'name': selectedJob,
                        'qty': double.tryParse(qtyController.text) ?? 0,
                        'unit': jobDetail['unit'],
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
    );
  }

  void _addLaborDialog() {
    String? selectedName;
    final qtyController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Tambah Tenaga Kerja'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Nama'),
                  items:
                      _laborOptions.map((name) {
                        return DropdownMenuItem(value: name, child: Text(name));
                      }).toList(),
                  onChanged: (val) {
                    selectedName = val;
                  },
                ),
                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Jumlah'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedName != null && qtyController.text.isNotEmpty) {
                    setState(() {
                      _laborList.add({
                        'name': selectedName,
                        'qty': int.tryParse(qtyController.text) ?? 0,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
    );
  }

  Future<void> _pickPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _photo = File(picked.path);
      });
    }
  }

  void _submit() {
    if (_selectedProject == null || _selectedWeather == null) return;

    final report = {
      'project': _selectedProject,
      'date': "${_selectedDate.toLocal()}".split(' ')[0],
      'weather': _selectedWeather!,
      'jobs': _jobList,
      'labor': _laborList,
      'photo': _photo,
    };
    Navigator.pop(context, report);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Laporan Harian'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField(
              value: _selectedProject,
              decoration: const InputDecoration(labelText: 'Proyek'),
              items:
                  _projectOptions.map((proj) {
                    return DropdownMenuItem(value: proj, child: Text(proj));
                  }).toList(),
              onChanged: (val) => setState(() => _selectedProject = val),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _selectedWeather,
              decoration: const InputDecoration(labelText: 'Cuaca'),
              items:
                  _weatherOptions.map((cuaca) {
                    return DropdownMenuItem(value: cuaca, child: Text(cuaca));
                  }).toList(),
              onChanged: (val) => setState(() => _selectedWeather = val),
            ),
            const SizedBox(height: 10),
            const Text('Pekerjaan'),
            ..._jobList.map(
              (job) => Text("- ${job['name']} (${job['qty']} ${job['unit']})"),
            ),
            ElevatedButton.icon(
              onPressed: _addJobDialog,
              icon: const Icon(Icons.work),
              label: const Text('Tambah Pekerjaan'),
            ),
            const SizedBox(height: 10),
            const Text('Tenaga Kerja'),
            ..._laborList.map(
              (lab) => Text("- ${lab['name']} (${lab['qty']})"),
            ),
            ElevatedButton.icon(
              onPressed: _addLaborDialog,
              icon: const Icon(Icons.group_add),
              label: const Text('Tambah Tenaga Kerja'),
            ),
            const SizedBox(height: 10),
            if (_photo != null)
              Image.file(_photo!, height: 100)
            else
              TextButton.icon(
                onPressed: _pickPhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tambah Foto Dokumentasi'),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Simpan')),
      ],
    );
  }
}
