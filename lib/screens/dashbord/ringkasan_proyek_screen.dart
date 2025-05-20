import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RingkasanProyekScreen extends StatefulWidget {
  const RingkasanProyekScreen({super.key});

  @override
  State<RingkasanProyekScreen> createState() => _RingkasanProyekScreenState();
}

class _RingkasanProyekScreenState extends State<RingkasanProyekScreen> {
  final List<Proyek> _daftarProyek = [
    Proyek(
      nama: 'Pembangunan Gedung A',
      lokasi: 'Jakarta Pusat',
      mulai: DateTime(2023, 1, 15),
      selesai: DateTime(2023, 12, 20),
      anggaran: 2500000000,
      progres: 75,
      tahapan: [
        Tahapan(nama: 'Persiapan', progres: 100),
        Tahapan(nama: 'Struktur', progres: 80),
        Tahapan(nama: 'Arsitektur', progres: 65),
        Tahapan(nama: 'Finishing', progres: 30),
      ],
    ),
    Proyek(
      nama: 'Jalan Tol B-C',
      lokasi: 'Jawa Barat',
      mulai: DateTime(2023, 3, 10),
      selesai: DateTime(2024, 6, 15),
      anggaran: 5000000000,
      progres: 42,
      tahapan: [
        Tahapan(nama: 'Land Clearing', progres: 100),
        Tahapan(nama: 'Tanah & Drainase', progres: 60),
        Tahapan(nama: 'Perkerasan', progres: 25),
        Tahapan(nama: 'Marking', progres: 0),
      ],
    ),
  ];

  int _selectedProjectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final proyek = _daftarProyek[_selectedProjectIndex];
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Proyek'),
        backgroundColor: Colors.blue,
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project selector dropdown
            _buildProjectSelector(),
            const SizedBox(height: 20),

            // Project summary card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          proyek.nama,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Chip(
                          label: Text(
                            '${proyek.progres}%',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _getProgressColor(proyek.progres),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lokasi: ${proyek.lokasi}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(proyek.progres),
                    const SizedBox(height: 16),
                    _buildProjectTimeline(proyek),
                    const SizedBox(height: 16),
                    _buildBudgetInfo(proyek, formatCurrency),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Project phases
            const Text(
              'Tahapan Proyek',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...proyek.tahapan.map((tahap) => _buildPhaseCard(tahap)).toList(),
            const SizedBox(height: 20),

            // Team members
            _buildTeamSection(),
            const SizedBox(height: 20),

            // Recent activities
            _buildRecentActivities(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReportDialog();
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Laporan',
      ),
    );
  }

  Widget _buildProjectSelector() {
    return DropdownButtonFormField<int>(
      value: _selectedProjectIndex,
      items:
          _daftarProyek.asMap().entries.map((entry) {
            return DropdownMenuItem<int>(
              value: entry.key,
              child: Text(entry.value.nama),
            );
          }).toList(),
      onChanged: (index) {
        setState(() {
          _selectedProjectIndex = index!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Pilih Proyek',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildProgressBar(int progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Progress Proyek'),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress / 100,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            _getProgressColor(progress),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text('$progress% selesai'),
        ),
      ],
    );
  }

  Widget _buildProjectTimeline(Proyek proyek) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mulai', style: TextStyle(color: Colors.grey)),
            Text(dateFormat.format(proyek.mulai)),
          ],
        ),
        Column(
          children: [
            const Text('Durasi'),
            Text(
              '${proyek.selesai.difference(proyek.mulai).inDays ~/ 30} bulan',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Target Selesai', style: TextStyle(color: Colors.grey)),
            Text(dateFormat.format(proyek.selesai)),
          ],
        ),
      ],
    );
  }

  Widget _buildBudgetInfo(Proyek proyek, NumberFormat formatCurrency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anggaran Proyek',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(formatCurrency.format(proyek.anggaran)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.65, // Replace with actual spent percentage
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Terkeluarkan: Rp 1.625.000.000'),
            Text('Sisa: Rp 875.000.000'),
          ],
        ),
      ],
    );
  }

  Widget _buildPhaseCard(Tahapan tahap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tahap.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${tahap.progres}%'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: tahap.progres / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(tahap.progres),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tim Proyek',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth =
                constraints.maxWidth * 0.4; // 40% dari lebar layar
            return SizedBox(
              height: 120, // Tinggi yang cukup untuk menampilkan informasi
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Jumlah anggota tim
                itemBuilder: (context, index) {
                  final teamMembers = [
                    {'name': 'John Doe', 'role': 'Project Manager'},
                    {'name': 'Jane Smith', 'role': 'Site Engineer'},
                    {'name': 'Robert Johnson', 'role': 'Arsitek'},
                    {'name': 'Sarah Lee', 'role': 'Quantity Surveyor'},
                    {'name': 'Mike Brown', 'role': 'Supervisor'},
                  ];

                  return Container(
                    width: cardWidth,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person, size: 20),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              teamMembers[index]['name']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              teamMembers[index]['role']!,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aktivitas Terkini',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildActivityItem(
                  'Pengecoran lantai 3 selesai',
                  'Hari ini, 10:30',
                  Icons.construction,
                ),
                const Divider(),
                _buildActivityItem(
                  'Material semen tiba di lokasi',
                  'Kemarin, 14:15',
                  Icons.local_shipping,
                ),
                const Divider(),
                _buildActivityItem(
                  'Inspeksi keselamatan dilakukan',
                  '2 hari lalu',
                  Icons.safety_check,
                ),
                const Divider(),
                _buildActivityItem(
                  'Progress meeting mingguan',
                  '3 hari lalu',
                  Icons.meeting_room,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(time),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Handle activity tap
      },
    );
  }

  Color _getProgressColor(int progress) {
    if (progress < 30) return Colors.red;
    if (progress < 70) return Colors.orange;
    return Colors.green;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Filter Proyek'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: const Text('Proyek Aktif'),
                  value: true,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text('Proyek Selesai'),
                  value: false,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text('Proyek Tertunda'),
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Apply filters
                },
                child: const Text('Terapkan'),
              ),
            ],
          ),
    );
  }

  void _showAddReportDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Laporan'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Judul Laporan',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
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
                      content: Text('Laporan berhasil ditambahkan'),
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

class Proyek {
  final String nama;
  final String lokasi;
  final DateTime mulai;
  final DateTime selesai;
  final double anggaran;
  final int progres;
  final List<Tahapan> tahapan;

  Proyek({
    required this.nama,
    required this.lokasi,
    required this.mulai,
    required this.selesai,
    required this.anggaran,
    required this.progres,
    required this.tahapan,
  });
}

class Tahapan {
  final String nama;
  final int progres;

  Tahapan({required this.nama, required this.progres});
}
