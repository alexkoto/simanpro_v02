import 'package:flutter/material.dart';
import 'package:simanpro_v02/screens/kendaraan/equipment_tracking_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> equipmentItems = [
      {
        'title': 'Equipment Tracking',
        'icon': Icons.location_searching,
        'screen': const EquipmentTrackingScreen(),
      },
      {
        'title': 'Maintenance Log',
        'icon': Icons.build_circle,
        'screen': Placeholder(),
      },
      {
        'title': 'Fuel Monitoring',
        'icon': Icons.local_gas_station,
        'screen': Placeholder(),
      },
      {
        'title': 'Peminjaman Kendaraan & Alat Berat',
        'icon': Icons.car_rental,
        'screen': Placeholder(),
      },
      {
        'title': 'Jatuh Tempo Pajak & Perizinan',
        'icon': Icons.assignment_late,
        'screen': Placeholder(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment & Kendaraan'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: equipmentItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = equipmentItems[index];
          return InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['screen']),
                ),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 40, color: Colors.blueAccent),
                  const SizedBox(height: 12),
                  Text(
                    item['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
