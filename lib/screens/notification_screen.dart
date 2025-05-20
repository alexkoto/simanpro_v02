import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Proyek Gedung Serbaguna',
      'message': 'Progress proyek mencapai 70%',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'type': 'progress',
      'read': false,
    },
    {
      'title': 'Penerangan Desa Rejo',
      'message': 'Material belum dikirim oleh vendor.',
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      'type': 'warning',
      'read': false,
    },
    {
      'title': 'Gardu Beton',
      'message': 'Biaya melebihi estimasi awal.',
      'time': DateTime.now().subtract(const Duration(days: 3)),
      'type': 'finance',
      'read': true,
    },
  ];

  Icon _getIcon(String type) {
    switch (type) {
      case 'progress':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'warning':
        return const Icon(Icons.warning, color: Colors.orange);
      case 'finance':
        return const Icon(Icons.attach_money, color: Colors.red);
      default:
        return const Icon(Icons.notifications);
    }
  }

  String _timeAgo(DateTime time) {
    final Duration diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit yang lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam yang lalu';
    return '${diff.inDays} hari yang lalu';
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notifikasi'),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            leading: _getIcon(notif['type']),
            title: Text(
              notif['title'],
              style: TextStyle(
                fontWeight: notif['read'] ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notif['message']),
                const SizedBox(height: 4),
                Text(
                  _timeAgo(notif['time']),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing:
                !notif['read']
                    ? IconButton(
                      icon: const Icon(Icons.mark_email_read),
                      onPressed: () => _markAsRead(index),
                    )
                    : null,
          );
        },
      ),
    );
  }
}
