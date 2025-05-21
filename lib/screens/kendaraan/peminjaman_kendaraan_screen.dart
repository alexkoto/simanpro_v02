import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class PeminjamanKendaraanScreen extends StatefulWidget {
  const PeminjamanKendaraanScreen({super.key});

  @override
  State<PeminjamanKendaraanScreen> createState() =>
      _PeminjamanKendaraanScreenState();
}

class _PeminjamanKendaraanScreenState extends State<PeminjamanKendaraanScreen> {
  final List<Map<String, dynamic>> _peminjamanList = [];

  final List<String> _listProyek = ['Proyek A', 'Proyek B', 'Proyek C'];

  final List<String> _listKendaraan = [
    'Mobil Operasional 1',
    'Alat Berat 1',
    'Truck 2',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<File?> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  void _showAddDialog() {
    String? selectedProyek;
    String? selectedKendaraan;
    final namaPeminjamController = TextEditingController();
    final kmTerakhirController = TextEditingController();
    final lamaPeminjamanController = TextEditingController();
    final kondisiFisikController = TextEditingController();
    final catatanController = TextEditingController();
    DateTime tanggalPakai = DateTime.now();
    DateTime tanggalKembali = DateTime.now().add(const Duration(days: 1));

    File? fotoKiri;
    File? fotoKanan;
    File? fotoDepan;
    File? fotoBelakang;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Peminjaman Kendaraan'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedProyek,
                      hint: const Text('Pilih Proyek'),
                      items:
                          _listProyek.map((proyek) {
                            return DropdownMenuItem(
                              value: proyek,
                              child: Text(proyek),
                            );
                          }).toList(),
                      onChanged:
                          (val) => setModalState(() => selectedProyek = val),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedKendaraan,
                      hint: const Text('Pilih Kendaraan'),
                      items:
                          _listKendaraan.map((kendaraan) {
                            return DropdownMenuItem(
                              value: kendaraan,
                              child: Text(kendaraan),
                            );
                          }).toList(),
                      onChanged:
                          (val) => setModalState(() => selectedKendaraan = val),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: namaPeminjamController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Peminjam',
                      ),
                    ),
                    TextField(
                      controller: kmTerakhirController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'KM Terakhir',
                      ),
                    ),
                    TextField(
                      controller: lamaPeminjamanController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Lama Peminjaman (hari)',
                      ),
                    ),
                    TextField(
                      controller: kondisiFisikController,
                      decoration: const InputDecoration(
                        labelText: 'Cek Fisik Kendaraan',
                      ),
                    ),
                    TextField(
                      controller: catatanController,
                      decoration: const InputDecoration(
                        labelText: 'Catatan Tambahan',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Tanggal Dipakai:'),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd-MM-yyyy').format(tanggalPakai)),
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: tanggalPakai,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null)
                              setModalState(() => tanggalPakai = picked);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Tanggal Kembali:'),
                        const SizedBox(width: 8),
                        Text(DateFormat('dd-MM-yyyy').format(tanggalKembali)),
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: tanggalKembali,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null)
                              setModalState(() => tanggalKembali = picked);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _fotoButton('Foto Kiri', fotoKiri, () async {
                          final img = await _pickImage();
                          if (img != null) setModalState(() => fotoKiri = img);
                        }),
                        _fotoButton('Foto Kanan', fotoKanan, () async {
                          final img = await _pickImage();
                          if (img != null) setModalState(() => fotoKanan = img);
                        }),
                        _fotoButton('Foto Depan', fotoDepan, () async {
                          final img = await _pickImage();
                          if (img != null) setModalState(() => fotoDepan = img);
                        }),
                        _fotoButton('Foto Belakang', fotoBelakang, () async {
                          final img = await _pickImage();
                          if (img != null)
                            setModalState(() => fotoBelakang = img);
                        }),
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
                    if (selectedProyek != null && selectedKendaraan != null) {
                      setState(() {
                        _peminjamanList.add({
                          'proyek': selectedProyek,
                          'kendaraan': selectedKendaraan,
                          'nama': namaPeminjamController.text,
                          'km': kmTerakhirController.text,
                          'lama': lamaPeminjamanController.text,
                          'kondisi': kondisiFisikController.text,
                          'catatan': catatanController.text,
                          'tglPakai': tanggalPakai,
                          'tglKembali': tanggalKembali,
                          'fotoKiri': fotoKiri,
                          'fotoKanan': fotoKanan,
                          'fotoDepan': fotoDepan,
                          'fotoBelakang': fotoBelakang,
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

  Widget _fotoButton(String label, File? image, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                image != null
                    ? Image.file(image, fit: BoxFit.cover)
                    : Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Peminjaman Kendaraan'),
      body:
          _peminjamanList.isEmpty
              ? const Center(child: Text('Belum ada data peminjaman.'))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _peminjamanList.length,
                itemBuilder: (context, index) {
                  final item = _peminjamanList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text('${item['kendaraan']} - ${item['proyek']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Peminjam: ${item['nama']}'),
                          Text('KM: ${item['km']}'),
                          Text('Lama: ${item['lama']} hari'),
                          Text('Fisik: ${item['kondisi']}'),
                          Text('Catatan: ${item['catatan']}'),
                          Text(
                            'Dipakai: ${DateFormat('dd-MM-yyyy').format(item['tglPakai'])}',
                          ),
                          Text(
                            'Dikembalikan: ${DateFormat('dd-MM-yyyy').format(item['tglKembali'])}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
