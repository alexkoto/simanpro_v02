import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class RingkasanProyekScreen extends StatefulWidget {
  const RingkasanProyekScreen({super.key});

  @override
  State<RingkasanProyekScreen> createState() => _RingkasanProyekScreenState();
}

class _RingkasanProyekScreenState extends State<RingkasanProyekScreen> {
  final List<Proyek> _daftarProyek = [
    Proyek(
      nama: 'Pemasangan PJU Solar Cell',
      lokasi: 'Pekanbaru Kota',
      mulai: DateTime(2023, 3, 5),
      selesai: DateTime(2023, 6, 20),
      terpakai: 185000000,
      anggaran: 250000000,
      progres: 74,
      tim: [
        AnggotaTim(nama: 'Alex Candra', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Badrul', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Cindy', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Survey Lokasi', progres: 100),
        Tahapan(nama: 'Pemasangan Tiang', progres: 80),
        Tahapan(nama: 'Instalasi Panel Surya', progres: 60),
        Tahapan(nama: 'Pengujian', progres: 40),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan tiang selesai',
          deskripsi: 'Pemasangan tiang PJU di lokasi A selesai.',
          waktu: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Aktivitas(
          judul: 'Pengujian panel surya',
          deskripsi: 'Pengujian panel surya di lokasi B.',
          waktu: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    ),
    Proyek(
      nama: 'Perbaikan Jaringan Listrik Kampus',
      lokasi: 'Universitas Riau, Pekanbaru',
      mulai: DateTime(2023, 4, 10),
      selesai: DateTime(2023, 8, 15),
      terpakai: 320000000,
      anggaran: 400000000,
      progres: 80,
      tim: [
        AnggotaTim(nama: 'Saipul Anwar', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Yusi', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Mita', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pengecekan Kerusakan', progres: 100),
        Tahapan(nama: 'Penggantian Kabel', progres: 75),
        Tahapan(nama: 'Perbaikan Panel', progres: 50),
        Tahapan(nama: 'Testing Jaringan', progres: 25),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Penggantian kabel selesai',
          deskripsi: 'Kabel baru sudah terpasang di gedung A.',
          waktu: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Aktivitas(
          judul: 'Pemeriksaan panel listrik',
          deskripsi: 'Panel listrik di gedung B sudah diperiksa.',
          waktu: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
    ),
    Proyek(
      nama: 'Instalasi Listrik Rumah Sakit Awal Bros',
      lokasi: 'Dumai',
      mulai: DateTime(2023, 2, 1),
      selesai: DateTime(2023, 5, 30),
      terpakai: 275000000,
      anggaran: 350000000,
      progres: 79,
      tim: [
        AnggotaTim(nama: 'Juni Anita', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Dika', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Cindy', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Perencanaan Teknis', progres: 100),
        Tahapan(nama: 'Pemasangan Kabel', progres: 85),
        Tahapan(nama: 'Instalasi MCB & Panel', progres: 65),
        Tahapan(nama: 'Uji Coba', progres: 45),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan kabel selesai',
          deskripsi: 'Kabel sudah terpasang di semua ruangan.',
          waktu: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Aktivitas(
          judul: 'Instalasi MCB selesai',
          deskripsi: 'MCB sudah terpasang di panel listrik.',
          waktu: DateTime.now().subtract(const Duration(days: 6)),
        ),
      ],
    ),
    Proyek(
      nama: 'Rehabilitasi Gardu Listrik',
      lokasi: 'Panam, Pekanbaru',
      mulai: DateTime(2023, 5, 15),
      selesai: DateTime(2023, 9, 10),
      terpakai: 410000000,
      anggaran: 480000000,
      progres: 85,
      tim: [
        AnggotaTim(nama: 'Mita', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Badrul', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Yusi', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pemeriksaan Kondisi', progres: 100),
        Tahapan(nama: 'Penggantian Trafo', progres: 80),
        Tahapan(nama: 'Perbaikan Kabel', progres: 70),
        Tahapan(nama: 'Pengujian Sistem', progres: 50),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Penggantian trafo selesai',
          deskripsi: 'Trafo baru sudah terpasang dan berfungsi.',
          waktu: DateTime.now().subtract(const Duration(days: 7)),
        ),
        Aktivitas(
          judul: 'Pemeriksaan kabel selesai',
          deskripsi: 'Kabel sudah diperiksa dan diganti.',
          waktu: DateTime.now().subtract(const Duration(days: 8)),
        ),
      ],
    ),
    Proyek(
      nama: 'Pembangunan Listrik Pedesaan',
      lokasi: 'Kampar',
      mulai: DateTime(2023, 6, 1),
      selesai: DateTime(2023, 10, 30),
      terpakai: 380000000,
      anggaran: 450000000,
      progres: 84,
      tim: [
        AnggotaTim(nama: 'Saipul Anwar', peran: 'Manajer Proyek'),
        AnggotaTim(nama: 'Alex Candra', peran: 'Teknisi Listrik'),
        AnggotaTim(nama: 'Juni Anita', peran: 'Quality Control'),
      ],
      tahapan: [
        Tahapan(nama: 'Pemetaan Jaringan', progres: 100),
        Tahapan(nama: 'Pemasangan Tiang', progres: 75),
        Tahapan(nama: 'Penarikan Kabel', progres: 60),
        Tahapan(nama: 'Sambungan Rumah', progres: 40),
      ],
      aktivitas: [
        Aktivitas(
          judul: 'Pemasangan tiang selesai',
          deskripsi: 'Tiang listrik sudah terpasang di lokasi A.',
          waktu: DateTime.now().subtract(const Duration(days: 9)),
        ),
        Aktivitas(
          judul: 'Penarikan kabel selesai',
          deskripsi: 'Kabel sudah ditarik ke rumah-rumah warga.',
          waktu: DateTime.now().subtract(const Duration(days: 10)),
        ),
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
      appBar: const CustomAppBar(title: 'Ringkasan Proyek'),

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
                      children: [
                        Expanded(
                          child: Text(
                            proyek.nama,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true, // opsional, default-nya true
                            maxLines: null, // izinkan multiline
                          ),
                        ),
                        const SizedBox(width: 8),
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
            ...proyek.tahapan.map((tahap) => _buildPhaseCard(tahap)),
            const SizedBox(height: 20),

            // Team members
            _buildTeamSection(proyek),
            const SizedBox(height: 20),

            // Recent activities
            _buildRecentActivities(proyek),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReportDialog();
        },
        tooltip: 'Tambah Laporan',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProjectSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // beri jarak vertikal
      child: Row(
        children: [
          Expanded(
            // pastikan dropdown bisa meluas horizontal
            child: DropdownButtonFormField<int>(
              isExpanded: true, // memungkinkan teks meluas horizontal
              value: _selectedProjectIndex,
              items:
                  _daftarProyek.asMap().entries.map((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(
                        entry.value.nama,
                        overflow:
                            TextOverflow
                                .ellipsis, // cegah teks panjang overflow
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
              onChanged: (index) {
                setState(() {
                  _selectedProjectIndex = index!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pilih Proyek',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mulai', style: TextStyle(color: Colors.blue)),
              Text(dateFormat.format(proyek.mulai)),
            ],
          ),
          const SizedBox(width: 20), // Beri jarak antar kolom jika diperlukan
          Column(
            children: [
              const Text('Durasi'),
              Text(
                '${proyek.selesai.difference(proyek.mulai).inDays ~/ 30} bulan',
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Target Selesai', style: TextStyle(color: Colors.red)),
              Text(dateFormat.format(proyek.selesai)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetInfo(Proyek proyek, NumberFormat formatCurrency) {
    final double total = proyek.anggaran;
    final double terpakai = proyek.terpakai;
    final double sisa = total - terpakai;

    // Untuk menghindari pembagian dengan nol
    final double persenTerpakai = total > 0 ? terpakai / total : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Anggaran Proyek',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(formatCurrency.format(total)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: persenTerpakai.clamp(0.0, 1.0), // Membatasi dari 0 sampai 1
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                'Terkeluarkan: ${formatCurrency.format(terpakai)}',
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 30),
              Text(
                'Sisa: ${formatCurrency.format(sisa)}',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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

  // Widget _buildTeamSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Tim Proyek',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 10),
  //       LayoutBuilder(
  //         builder: (context, constraints) {
  //           final cardWidth =
  //               constraints.maxWidth * 0.4; // 40% dari lebar layar
  //           return SizedBox(
  //             height: 120, // Tinggi yang cukup untuk menampilkan informasi
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: 5, // Jumlah anggota tim
  //               itemBuilder: (context, index) {
  //                 final teamMembers = [
  //                   {'name': 'Saipul Anwar', 'role': 'Manajer Proyek'},
  //                   {'name': 'Andi Setiawan', 'role': 'Site Engineer'},
  //                   {'name': 'Dewi Lestari', 'role': 'Perencana Listrik'},
  //                   {'name': 'Rizky Maulana', 'role': 'Quantity Surveyor'},
  //                   {'name': 'Budi Hartono', 'role': 'Pengawas Lapangan'},
  //                 ];
  //                 if (index >= teamMembers.length) return const SizedBox();
  //                 // Menghindari index out of range
  //                 return Container(
  //                   width: cardWidth,
  //                   margin: const EdgeInsets.only(right: 12),
  //                   child: Card(
  //                     elevation: 2,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           const CircleAvatar(
  //                             radius: 20,
  //                             child: Icon(Icons.person, size: 20),
  //                           ),
  //                           const SizedBox(height: 8),
  //                           Text(
  //                             teamMembers[index]['name']!,
  //                             style: const TextStyle(
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             textAlign: TextAlign.center,
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           Text(
  //                             teamMembers[index]['role']!,
  //                             style: TextStyle(
  //                               fontSize: 10,
  //                               color: Colors.grey[600],
  //                             ),
  //                             textAlign: TextAlign.center,
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildTeamSection(Proyek proyek) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tim Proyek',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: proyek.tim.length,
            itemBuilder: (context, index) {
              final anggota = proyek.tim[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  elevation: 2,
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
                          anggota.nama,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          anggota.peran,
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
        ),
      ],
    );
  }

  // Widget _buildRecentActivities() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Aktivitas Terkini',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 10),
  //       Card(
  //         child: Padding(
  //           padding: const EdgeInsets.all(12),
  //           child: Column(
  //             children: [
  //               _buildActivityItem(
  //                 'Pemasangan trafo distribusi selesai',
  //                 'Hari ini, 10:30',
  //                 Icons.electrical_services,
  //               ),
  //               const Divider(),
  //               _buildActivityItem(
  //                 'Material kabel TR dan SR tiba di lokasi',
  //                 'Kemarin, 14:15',
  //                 Icons.local_shipping,
  //               ),
  //               const Divider(),
  //               _buildActivityItem(
  //                 'Pemeriksaan grounding system',
  //                 '2 hari lalu',
  //                 Icons.bolt,
  //               ),
  //               const Divider(),
  //               _buildActivityItem(
  //                 'Koordinasi pekerjaan jaringan dengan PLN',
  //                 '3 hari lalu',
  //                 Icons.group,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildRecentActivities(Proyek proyek) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aktivitas Terkini',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              ...proyek.aktivitas.map(
                (aktivitas) => Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.event_note, color: Colors.blue),
                      title: Text(aktivitas.judul),
                      subtitle: Text(dateFormat.format(aktivitas.waktu)),
                      trailing: const Icon(Icons.chevron_right),
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (aktivitas != proyek.aktivitas.last) const Divider(),
                  ],
                ),
              ),
            ],
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
  final double terpakai;
  final int progres;
  final List<Tahapan> tahapan;
  final List<AnggotaTim> tim;
  final List<Aktivitas> aktivitas;

  Proyek({
    required this.nama,
    required this.lokasi,
    required this.mulai,
    required this.selesai,
    required this.anggaran,
    required this.terpakai,
    required this.progres,
    required this.tahapan,
    required this.tim,
    required this.aktivitas,
  });
}

class Aktivitas {
  final String judul;
  final String? deskripsi;
  final DateTime waktu;

  Aktivitas({required this.judul, this.deskripsi, required this.waktu});
}

class AnggotaTim {
  final String nama;
  final String peran;

  AnggotaTim({required this.nama, required this.peran});
}

class Tahapan {
  final String nama;
  final int progres;

  Tahapan({required this.nama, required this.progres});
}
