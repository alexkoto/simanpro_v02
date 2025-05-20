import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class TimelineSchedulingScreen extends StatefulWidget {
  const TimelineSchedulingScreen({super.key});

  @override
  State<TimelineSchedulingScreen> createState() =>
      _TimelineSchedulingScreenState();
}

class _TimelineSchedulingScreenState extends State<TimelineSchedulingScreen> {
  int _selectedProjectIndex = 0;

  final List<Project> _projects = [
    Project(
      name: 'Pembangunan Gedung A',
      timelines: [
        {'phase': 'Perencanaan', 'date': '2025-05-01', 'status': 'Selesai'},
        {
          'phase': 'Persiapan Lokasi',
          'date': '2025-05-05',
          'status': 'Selesai',
        },
        {
          'phase': 'Konstruksi Awal',
          'date': '2025-05-10',
          'status': 'Berjalan',
        },
        {
          'phase': 'Pemasangan Listrik',
          'date': '2025-05-20',
          'status': 'Menunggu',
        },
        {
          'phase': 'Pengujian & Serah Terima',
          'date': '2025-05-30',
          'status': 'Menunggu',
        },
      ],
    ),
    Project(
      name: 'Jalan Tol B-C',
      timelines: [
        {'phase': 'Land Clearing', 'date': '2025-04-15', 'status': 'Selesai'},
        {
          'phase': 'Pekerjaan Tanah',
          'date': '2025-05-01',
          'status': 'Berjalan',
        },
        {
          'phase': 'Perkerasan Jalan',
          'date': '2025-06-10',
          'status': 'Menunggu',
        },
        {'phase': 'Marking Jalan', 'date': '2025-07-01', 'status': 'Menunggu'},
        {
          'phase': 'Final Inspection',
          'date': '2025-07-15',
          'status': 'Menunggu',
        },
      ],
    ),
    Project(
      name: 'Renovasi Rumah Sakit',
      timelines: [
        {'phase': 'Perencanaan', 'date': '2025-06-01', 'status': 'Menunggu'},
        {'phase': 'Pembongkaran', 'date': '2025-06-15', 'status': 'Menunggu'},
        {'phase': 'Konstruksi', 'date': '2025-07-01', 'status': 'Menunggu'},
        {'phase': 'Finishing', 'date': '2025-08-01', 'status': 'Menunggu'},
      ],
    ),
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'berjalan':
        return Colors.orange;
      case 'menunggu':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Icons.check_circle;
      case 'berjalan':
        return Icons.autorenew;
      case 'menunggu':
        return Icons.schedule;
      default:
        return Icons.help_outline;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = _projects[_selectedProjectIndex];
    final timelines = currentProject.timelines;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Jadwal Proyek'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<int>(
              value: _selectedProjectIndex,
              decoration: InputDecoration(
                labelText: 'Pilih Proyek',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              items: List.generate(_projects.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(_projects[index].name),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _selectedProjectIndex = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: timelines.length,
              itemBuilder: (context, index) {
                final timeline = timelines[index];
                final isLast = index == timelines.length - 1;
                final statusColor = _getStatusColor(timeline['status']!);
                final statusIcon = _getStatusIcon(timeline['status']!);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline indicator
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: statusColor,
                              child: Icon(
                                statusIcon,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 70,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Timeline content
                      Expanded(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      timeline['phase']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: statusColor),
                                      ),
                                      child: Text(
                                        timeline['status']!,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _formatDate(timeline['date']!),
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                if (index < timelines.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Menuju: ${timelines[index + 1]['phase']}',
                                      style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTimelineDialog(context);
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Timeline',
      ),
    );
  }

  void _showAddTimelineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Timeline Baru'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tahapan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal (YYYY-MM-DD)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Menunggu',
                      child: Text('Menunggu'),
                    ),
                    DropdownMenuItem(
                      value: 'Berjalan',
                      child: Text('Berjalan'),
                    ),
                    DropdownMenuItem(value: 'Selesai', child: Text('Selesai')),
                  ],
                  onChanged: (value) {},
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
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Timeline berhasil ditambahkan'),
                    ),
                  );
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }
}

class Project {
  final String name;
  final List<Map<String, String>> timelines;

  Project({required this.name, required this.timelines});
}
