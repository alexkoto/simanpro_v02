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
      title: "Keterlambatan Proyek A",
      message: "Tahap konstruksi terlambat 3 hari dari jadwal",
      project: "Proyek A",
      date: DateTime.now().subtract(const Duration(hours: 2)),
      priority: Priority.high,
      isRead: false,
    ),
    AlertItem(
      title: "Material Habis",
      message: "Stok semen tinggal 10 sak, perlu pengadaan segera",
      project: "Proyek B",
      date: DateTime.now().subtract(const Duration(days: 1)),
      priority: Priority.medium,
      isRead: true,
    ),
    AlertItem(
      title: "Pembayaran Invoice",
      message: "Invoice dari PT. Jaya Abadi belum dibayar (jatuh tempo 2 hari)",
      project: "Semua Proyek",
      date: DateTime.now().subtract(const Duration(days: 3)),
      priority: Priority.high,
      isRead: false,
    ),
    AlertItem(
      title: "Laporan Bulanan",
      message: "Laporan bulan Januari belum disubmit",
      project: "Administrasi",
      date: DateTime.now().subtract(const Duration(days: 5)),
      priority: Priority.low,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistem Alert',
          style: TextStyle(
            fontSize: 18, // Slightly smaller font
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari alert...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      // Implement search functionality
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _alerts.length,
              itemBuilder: (context, index) {
                final alert = _alerts[index];
                return _buildAlertCard(alert);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAlert,
        child: const Icon(Icons.add_alert),
      ),
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
                // Implement action for this alert
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
