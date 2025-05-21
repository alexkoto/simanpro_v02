import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({super.key});

  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  final List<Map<String, dynamic>> _equipmentList = [
    {
      'jenis': 'Excavator',
      'manufaktur': 'Komatsu',
      'tipe': 'PC200-8',
      'plat': 'BM 1234 XYZ',
      'tahun': '2019',
      'nomorMesin': 'EXC-456789',
      'nomorRangka': 'RGK-123456',
      'ikon': Icons.precision_manufacturing,
    },
    {
      'jenis': 'Mobil Operasional',
      'manufaktur': 'Daihatsu',
      'tipe': 'Grand Max 1.3 G Minibus',
      'plat': 'BM 1403 AT',
      'tahun': '2017',
      'nomorMesin': 'OPS-098765',
      'nomorRangka': 'RGK-654321',
      'ikon': Icons.directions_car,
    },
    {
      'jenis': 'Mobil Operasional',
      'manufaktur': 'Daihatsu',
      'tipe': 'Grand Max 1.3 G Blind Van',
      'plat': 'BM 8337 TT',
      'tahun': '2017',
      'nomorMesin': 'OPS-098765',
      'nomorRangka': 'RGK-654321',
      'ikon': Icons.directions_car,
    },
  ];

  final List<String> _jenisKendaraanList = [
    'Excavator',
    'Bulldozer',
    'Dump Truck',
    'Mobil Operasional',
    'Forklift',
    'Mobil Pickup',
    'Motor Trail',
    'Crane',
    'Tractor',
    'Loader',
  ];

  void _tambahEquipment() {
    String? selectedJenis;
    final manufakturController = TextEditingController();
    final tipeController = TextEditingController();
    final platController = TextEditingController();
    final tahunController = TextEditingController();
    final mesinController = TextEditingController();
    final rangkaController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Kendaraan/Alat'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedJenis,
                    hint: const Text('Pilih Jenis Kendaraan'),
                    items:
                        _jenisKendaraanList
                            .map(
                              (jenis) => DropdownMenuItem(
                                value: jenis,
                                child: Text(jenis),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => selectedJenis = value,
                  ),
                  TextField(
                    controller: manufakturController,
                    decoration: const InputDecoration(labelText: 'Manufaktur'),
                  ),
                  TextField(
                    controller: tipeController,
                    decoration: const InputDecoration(
                      labelText: 'Tipe Kendaraan',
                    ),
                  ),
                  TextField(
                    controller: platController,
                    decoration: const InputDecoration(labelText: 'Nomor Plat'),
                  ),
                  TextField(
                    controller: tahunController,
                    decoration: const InputDecoration(
                      labelText: 'Tahun Pembelian',
                    ),
                  ),
                  TextField(
                    controller: mesinController,
                    decoration: const InputDecoration(labelText: 'Nomor Mesin'),
                  ),
                  TextField(
                    controller: rangkaController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Rangka',
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
                  if (selectedJenis != null && platController.text.isNotEmpty) {
                    setState(() {
                      _equipmentList.add({
                        'jenis': selectedJenis,
                        'manufaktur': manufakturController.text,
                        'tipe': tipeController.text,
                        'plat': platController.text,
                        'tahun': tahunController.text,
                        'nomorMesin': mesinController.text,
                        'nomorRangka': rangkaController.text,
                        'ikon': _getIconForJenis(selectedJenis!),
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

  IconData _getIconForJenis(String jenis) {
    switch (jenis.toLowerCase()) {
      case 'excavator':
        return Icons.precision_manufacturing;
      case 'bulldozer':
        return Icons.agriculture;
      case 'dump truck':
        return Icons.local_shipping;
      case 'mobil operasional':
        return Icons.directions_car;
      case 'forklift':
        return Icons.electric_moped;
      case 'mobil pickup':
        return Icons.local_shipping_outlined;
      case 'motor trail':
        return Icons.motorcycle;
      case 'crane':
        return Icons.construction;
      case 'tractor':
        return Icons.agriculture;
      case 'loader':
        return Icons.settings_applications;
      default:
        return Icons.device_hub;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Daftar Kendaraan & Alat'),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      // ),
      appBar: const CustomAppBar(title: 'Daftar Kendaraan & Alat'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _equipmentList.length,
        itemBuilder: (context, index) {
          final item = _equipmentList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: ListTile(
              leading: Icon(item['ikon'], color: Colors.blue, size: 36),
              title: Text(
                '${item['jenis']} (${item['plat']})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manufaktur: ${item['manufaktur'] ?? '-'}'),
                  Text('Tipe: ${item['tipe'] ?? '-'}'),
                  Text('Tahun: ${item['tahun'] ?? '-'}'),
                  Text('No. Mesin: ${item['nomorMesin'] ?? '-'}'),
                  Text('No. Rangka: ${item['nomorRangka'] ?? '-'}'),
                ],
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Bisa arahkan ke detail atau edit
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahEquipment,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
