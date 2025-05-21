import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class EquipmentTrackingScreen extends StatefulWidget {
  const EquipmentTrackingScreen({super.key});

  @override
  State<EquipmentTrackingScreen> createState() =>
      _EquipmentTrackingScreenState();
}

class _EquipmentTrackingScreenState extends State<EquipmentTrackingScreen> {
  final List<Map<String, dynamic>> _equipmentList = [
    {
      'name': 'Excavator Hitachi ZX200',
      'location': 'Proyek A',
      'status': 'Aktif',
      'lastUpdate': '2025-05-21 14:25',
      'type': 'Excavator',
    },
    {
      'name': 'Bulldozer Komatsu D85',
      'location': 'Workshop Utama',
      'status': 'Maintenance',
      'lastUpdate': '2025-05-20 09:10',
      'type': 'Bulldozer',
    },
    {
      'name': 'Dump Truck Hino 500',
      'location': 'Proyek B',
      'status': 'Aktif',
      'lastUpdate': '2025-05-21 13:00',
      'type': 'Dump Truck',
    },
    {
      'name': 'Pick Up Mitsubishi L300',
      'location': 'Proyek C',
      'status': 'Tidak Aktif',
      'lastUpdate': '2025-05-19 10:00',
      'type': 'Pick Up',
    },

    {
      'name': 'Mobil Operasional Toyota Avanza',
      'location': 'Kantor Pusat',
      'status': 'Aktif',
      'lastUpdate': '2025-05-21 08:30',
      'type': 'Mobil Operasional',
    },
    {
      'name': 'Motor Honda Revo',
      'location': 'Proyek B',
      'status': 'Maintenance',
      'lastUpdate': '2025-05-20 11:00',
      'type': 'Motor Operasional',
    },
  ];

  IconData _getEquipmentIcon(String type) {
    switch (type) {
      case 'Excavator':
        return Icons.precision_manufacturing;
      case 'Bulldozer':
        return Icons.front_loader;
      case 'Dump Truck':
        return Icons.local_shipping;
      case 'Pick Up':
        return Icons.fire_truck;

      case 'Mobil Operasional':
        return Icons.directions_car_filled;
      case 'Motor Operasional':
        return Icons.motorcycle;
      default:
        return Icons.devices_other;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Aktif':
        return Colors.green;
      case 'Maintenance':
        return Colors.orange;
      case 'Tidak Aktif':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Equipment Tracking'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _equipmentList.length,
        itemBuilder: (context, index) {
          final item = _equipmentList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: Icon(
                _getEquipmentIcon(item['type']),
                size: 34,
                color: Colors.blueAccent,
              ),
              title: Text(item['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lokasi: ${item['location']}'),
                  Text('Update Terakhir: ${item['lastUpdate']}'),
                ],
              ),
              trailing: Chip(
                label: Text(item['status']),
                backgroundColor: _getStatusColor(
                  item['status'],
                ).withOpacity(0.2),
                labelStyle: TextStyle(
                  color: _getStatusColor(item['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Arahkan ke detail atau fungsi lainnya
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan fungsi tambah peralatan/alat baru
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
