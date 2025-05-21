import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class PurchaseOrderScreen extends StatelessWidget {
  const PurchaseOrderScreen({super.key});

  final List<Map<String, String>> _poList = const [
    {'kode': 'PO-001', 'vendor': 'Toko Sinar Lestari', 'status': 'Diproses'},
    {'kode': 'PO-002', 'vendor': 'CV. Kurnia Abadi', 'status': 'Terkirim'},
    {'kode': 'PO-003', 'vendor': 'Toko Besi Maju', 'status': 'Diterima'},
  ];

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'diproses':
        return Colors.orange;
      case 'terkirim':
        return Colors.blue;
      case 'diterima':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Purchase Order'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _poList.length,
        itemBuilder: (context, index) {
          final po = _poList[index];
          final statusColor = _statusColor(po['status']!);
          return Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(po['kode']!),
              subtitle: Text(po['vendor']!),
              trailing: Chip(
                backgroundColor: statusColor.withOpacity(0.1),
                label: Text(
                  po['status']!,
                  style: TextStyle(color: statusColor),
                ),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
