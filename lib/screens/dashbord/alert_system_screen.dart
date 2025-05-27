import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertSystemScreen extends StatefulWidget {
  const AlertSystemScreen({super.key});

  @override
  State<AlertSystemScreen> createState() => _AlertSystemScreenState();
}

class _AlertSystemScreenState extends State<AlertSystemScreen> {
  final List<AlertItem> _alerts = [
    AlertItem(
      title: "Keterlambatan Instalasi Panel Surya",
      message:
          "Tahap instalasi panel surya pada proyek Pemasangan PJU Solar Cell mengalami keterlambatan 3 hari dari jadwal.",
      project: "Pemasangan PJU Solar Cell",
      date: DateTime.now().subtract(const Duration(hours: 2)),
      priority: Priority.high,
      isRead: false,
    ),
    AlertItem(
      title: "Material Kabel Habis",
      message:
          "Stok kabel pada proyek Perbaikan Jaringan Listrik Kampus tinggal sedikit, perlu pengadaan segera.",
      project: "Perbaikan Jaringan Listrik Kampus",
      date: DateTime.now().subtract(const Duration(days: 1)),
      priority: Priority.medium,
      isRead: true,
    ),
    AlertItem(
      title: "Pembayaran Invoice",
      message:
          "Invoice dari PT. Jaya Abadi untuk proyek Instalasi Listrik Rumah Sakit Awal Bros belum dibayar (jatuh tempo 2 hari).",
      project: "Instalasi Listrik Rumah Sakit Awal Bros",
      date: DateTime.now().subtract(const Duration(days: 3)),
      priority: Priority.high,
      isRead: false,
    ),
    AlertItem(
      title: "Laporan Bulanan",
      message:
          "Laporan bulan Januari untuk proyek Rehabilitasi Gardu Listrik belum disubmit.",
      project: "Rehabilitasi Gardu Listrik",
      date: DateTime.now().subtract(const Duration(days: 5)),
      priority: Priority.low,
      isRead: true,
    ),
    AlertItem(
      title: "Cuaca Ekstrem Terdeteksi",
      message:
          "Cuaca ekstrem diperkirakan terjadi di lokasi proyek Pembangunan Listrik Pedesaan, penjadwalan ulang mungkin diperlukan.",
      project: "Pembangunan Listrik Pedesaan",
      date: DateTime.now().subtract(const Duration(hours: 5)),
      priority: Priority.high,
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: const Text(
          'Sistem Alert',
          style: TextStyle(
            fontSize: 18,
            // fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // Menambahkan warna tulisan putih

        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        toolbarHeight: 48.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: _markAllAsRead,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildAlertList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAlert,
        child: const Icon(Icons.add_alert),
      ),
    );
  }

  Widget _buildAlertList() {
    // Group alerts by project
    final groupedAlerts = <String, List<AlertItem>>{};
    for (var alert in _alerts) {
      groupedAlerts.putIfAbsent(alert.project, () => []).add(alert);
    }

    return ListView.builder(
      itemCount: groupedAlerts.keys.length,
      itemBuilder: (context, index) {
        final project = groupedAlerts.keys.elementAt(index);
        final alerts = groupedAlerts[project]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                project,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...alerts.map((alert) => _buildAlertCard(alert)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildAlertCard(AlertItem alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: alert.isRead ? Colors.white : Colors.blue[50],
      elevation: 2,
      child: InkWell(
        onTap: () {
          setState(() {
            alert.isRead = true;
          });
          _showAlertDetail(alert);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildPriorityIndicator(alert.priority),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alert.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: alert.isRead ? Colors.black : Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM HH:mm').format(alert.date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(alert.message, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Chip(
                label: Text(alert.project),
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(Priority priority) {
    IconData icon;
    Color color;

    switch (priority) {
      case Priority.high:
        icon = Icons.error;
        color = Colors.red;
        break;
      case Priority.medium:
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case Priority.low:
        icon = Icons.info;
        color = Colors.blue;
        break;
    }

    return Icon(icon, color: color, size: 20);
  }

  void _showAlertDetail(AlertItem alert) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(alert.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alert.message),
              const SizedBox(height: 16),
              Text(
                'Proyek: ${alert.project}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Waktu: ${DateFormat('dd/MM/yyyy HH:mm').format(alert.date)}',
              ),
              const SizedBox(height: 8),
              _buildPriorityChip(alert.priority),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('TUTUP'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tindakan untuk ${alert.title}')),
                );
              },
              child: const Text('TINDAK LANJUT'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPriorityChip(Priority priority) {
    String text;
    Color color;

    switch (priority) {
      case Priority.high:
        text = 'TINGGI';
        color = Colors.red;
        break;
      case Priority.medium:
        text = 'SEDANG';
        color = Colors.orange;
        break;
      case Priority.low:
        text = 'RENDAH';
        color = Colors.blue;
        break;
    }

    return Chip(
      label: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: const Text('Prioritas Tinggi'),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: const Text('Prioritas Sedang'),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: const Text('Prioritas Rendah'),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: const Text('Hanya yang belum dibaca'),
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('BATAL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement filter logic
              },
              child: const Text('TERAPKAN'),
            ),
          ],
        );
      },
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var alert in _alerts) {
        alert.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua alert ditandai sudah dibaca')),
    );
  }

  void _addNewAlert() {
    // Implement navigation to add new alert screen
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Fitur tambah alert baru')));
  }
}

class AlertItem {
  String title;
  String message;
  String project;
  DateTime date;
  Priority priority;
  bool isRead;

  AlertItem({
    required this.title,
    required this.message,
    required this.project,
    required this.date,
    required this.priority,
    required this.isRead,
  });
}

enum Priority { high, medium, low }
