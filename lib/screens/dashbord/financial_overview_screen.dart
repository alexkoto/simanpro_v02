import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class FinancialOverviewScreen extends StatefulWidget {
  const FinancialOverviewScreen({super.key});

  @override
  State<FinancialOverviewScreen> createState() =>
      _FinancialOverviewScreenState();
}

class _FinancialOverviewScreenState extends State<FinancialOverviewScreen> {
  final List<Proyek> _daftarProyek = [
    Proyek(
      nama: 'Pemasangan PJU Solar Cell',
      lokasi: 'Pekanbaru Kota',
      mulai: DateTime(2023, 3, 5),
      selesai: DateTime(2023, 6, 20),
      terpakai: 185000000,
      anggaran: 250000000,
      progres: 74,
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 75000000,
          tanggal: DateTime(2023, 3, 15),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 60000000,
          tanggal: DateTime(2023, 4, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 3',
          jumlah: 50000000,
          tanggal: DateTime(2023, 5, 25),
          status: 'Pending',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 120000000,
          items: [
            ItemPengeluaran(nama: 'Panel Surya', jumlah: 80000000),
            ItemPengeluaran(nama: 'Baterai', jumlah: 30000000),
            ItemPengeluaran(nama: 'Kabel', jumlah: 10000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 45000000,
          items: [
            ItemPengeluaran(nama: 'Gaji Teknisi', jumlah: 30000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 15000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 20000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 5000000),
            ItemPengeluaran(nama: 'Administrasi', jumlah: 15000000),
          ],
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
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 150000000,
          tanggal: DateTime(2023, 4, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 120000000,
          tanggal: DateTime(2023, 6, 10),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 200000000,
          items: [
            ItemPengeluaran(nama: 'Kabel NYY', jumlah: 100000000),
            ItemPengeluaran(nama: 'Panel LVMDP', jumlah: 100000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 80000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 50000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 40000000,
          items: [
            ItemPengeluaran(nama: 'Izin Kerja', jumlah: 10000000),
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 30000000),
          ],
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
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 150000000,
          tanggal: DateTime(2023, 2, 20),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 100000000,
          tanggal: DateTime(2023, 4, 5),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 180000000,
          items: [
            ItemPengeluaran(nama: 'Kabel', jumlah: 60000000),
            ItemPengeluaran(nama: 'MCB & Panel', jumlah: 60000000),
            ItemPengeluaran(nama: 'Tray Kabel', jumlah: 60000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 65000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 45000000),
            ItemPengeluaran(nama: 'Konsumsi & Transportasi', jumlah: 20000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 30000000,
          items: [
            ItemPengeluaran(nama: 'Administrasi', jumlah: 10000000),
            ItemPengeluaran(nama: 'Uji Kelayakan', jumlah: 20000000),
          ],
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
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 200000000,
          tanggal: DateTime(2023, 6, 1),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 150000000,
          tanggal: DateTime(2023, 7, 20),
          status: 'Lunas',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 250000000,
          items: [
            ItemPengeluaran(nama: 'Trafo Distribusi', jumlah: 150000000),
            ItemPengeluaran(nama: 'Kabel TM', jumlah: 100000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 100000000,
          items: [
            ItemPengeluaran(nama: 'Pemasangan', jumlah: 70000000),
            ItemPengeluaran(nama: 'Pengujian', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 60000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 10000000),
            ItemPengeluaran(nama: 'Survei Ulang', jumlah: 50000000),
          ],
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
      pembayaran: [
        Pembayaran(
          nama: 'Termin 1',
          jumlah: 200000000,
          tanggal: DateTime(2023, 6, 15),
          status: 'Lunas',
        ),
        Pembayaran(
          nama: 'Termin 2',
          jumlah: 100000000,
          tanggal: DateTime(2023, 8, 5),
          status: 'Pending',
        ),
      ],
      pengeluaran: [
        Pengeluaran(
          kategori: 'Material',
          jumlah: 250000000,
          items: [
            ItemPengeluaran(nama: 'Tiang Beton', jumlah: 120000000),
            ItemPengeluaran(nama: 'Kabel TR', jumlah: 80000000),
            ItemPengeluaran(nama: 'Aksesoris Jaringan', jumlah: 50000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Tenaga Kerja',
          jumlah: 90000000,
          items: [
            ItemPengeluaran(nama: 'Instalasi', jumlah: 60000000),
            ItemPengeluaran(nama: 'Transportasi', jumlah: 30000000),
          ],
        ),
        Pengeluaran(
          kategori: 'Lain-lain',
          jumlah: 40000000,
          items: [
            ItemPengeluaran(nama: 'Dokumentasi', jumlah: 15000000),
            ItemPengeluaran(nama: 'Keamanan', jumlah: 25000000),
          ],
        ),
      ],
    ),
    // Add more projects as needed
  ];

  int _selectedProjectIndex = 0;
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final proyek = _daftarProyek[_selectedProjectIndex];
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: const CustomAppBar(title: 'Overview Keuangan'),
      body: Column(
        children: [
          // Project selector
          _buildProjectSelector(),

          // Tab bar
          _buildFinanceTabBar(),

          // Tab content
          Expanded(child: _buildTabContent(proyek, formatCurrency)),
        ],
      ),
    );
  }

  Widget _buildProjectSelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField<int>(
        value: _selectedProjectIndex,
        isExpanded: true, // <-- tambahkan ini
        decoration: InputDecoration(
          labelText: 'Pilih Proyek',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items:
            _daftarProyek.asMap().entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.key,
                child: Text(
                  entry.value.nama,
                  overflow:
                      TextOverflow.ellipsis, // opsional, memotong teks panjang
                ),
              );
            }).toList(),
        onChanged: (index) {
          setState(() {
            _selectedProjectIndex = index!;
          });
        },
      ),
    );
  }

  Widget _buildFinanceTabBar() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            onTap: (index) => setState(() => _selectedTabIndex = index),
            tabs: const [
              Tab(text: 'Ringkasan'),
              Tab(text: 'Pembayaran'),
              Tab(text: 'Pengeluaran'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(Proyek proyek, NumberFormat formatCurrency) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildSummaryTab(proyek, formatCurrency);
      case 1:
        return _buildPaymentsTab(proyek, formatCurrency);
      case 2:
        return _buildExpensesTab(proyek, formatCurrency);
      default:
        return Container();
    }
  }

  Widget _buildSummaryTab(Proyek proyek, NumberFormat formatCurrency) {
    final double totalAnggaran = proyek.anggaran;
    final double totalTerpakai = proyek.terpakai;
    final double sisaAnggaran = totalAnggaran - totalTerpakai;
    final double persentaseTerpakai = (totalTerpakai / totalAnggaran) * 100;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 12), // Ubah ukuran teks di sini
        child: Column(
          children: [
            // Budget overview card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Anggaran',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ), // override jika perlu
                    ),
                    const SizedBox(height: 16),
                    _buildFinanceRow(
                      'Total Anggaran',
                      formatCurrency.format(totalAnggaran),
                      Colors.blue,
                    ),
                    _buildFinanceRow(
                      'Terkeluarkan',
                      formatCurrency.format(totalTerpakai),
                      Colors.orange,
                    ),
                    _buildFinanceRow(
                      'Sisa Anggaran',
                      formatCurrency.format(sisaAnggaran),
                      sisaAnggaran >= 0 ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: persentaseTerpakai / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        persentaseTerpakai > 80 ? Colors.red : Colors.blue,
                      ),
                      minHeight: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${persentaseTerpakai.toStringAsFixed(1)}% anggaran terpakai',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildPaymentStatus(proyek, formatCurrency),
            const SizedBox(height: 20),

            _buildExpenseBreakdown(proyek, formatCurrency),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 12,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus(Proyek proyek, NumberFormat formatCurrency) {
    final totalPembayaran = proyek.pembayaran.fold<double>(
      0,
      (sum, pembayaran) => sum + pembayaran.jumlah,
    );
    final pembayaranLunas = proyek.pembayaran
        .where((p) => p.status == 'Lunas')
        .fold<double>(0, (sum, p) => sum + p.jumlah);
    final persentaseLunas = (pembayaranLunas / totalPembayaran) * 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status Pembayaran',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFinanceRow(
              'Total Pembayaran',
              formatCurrency.format(totalPembayaran),
              Colors.blue,
            ),
            _buildFinanceRow(
              'Sudah Dibayar',
              formatCurrency.format(pembayaranLunas),
              Colors.green,
            ),
            _buildFinanceRow(
              'Belum Dibayar',
              formatCurrency.format(totalPembayaran - pembayaranLunas),
              Colors.orange,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: persentaseLunas / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                persentaseLunas > 80 ? Colors.green : Colors.blue,
              ),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              '${persentaseLunas.toStringAsFixed(1)}% pembayaran lunas',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseBreakdown(Proyek proyek, NumberFormat formatCurrency) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rincian Pengeluaran',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...proyek.pengeluaran.map((pengeluaran) {
              return Column(
                children: [
                  _buildFinanceRow(
                    pengeluaran.kategori,
                    formatCurrency.format(pengeluaran.jumlah),
                    Colors.purple,
                  ),
                  ...pengeluaran.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: _buildFinanceRow(
                        '- ${item.nama}',
                        formatCurrency.format(item.jumlah),
                        Colors.grey[600]!,
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsTab(Proyek proyek, NumberFormat formatCurrency) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: proyek.pembayaran.length,
      itemBuilder: (context, index) {
        final pembayaran = proyek.pembayaran[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor:
                  pembayaran.status == 'Lunas'
                      ? Colors.green[100]
                      : Colors.orange[100],
              child: Icon(
                pembayaran.status == 'Lunas' ? Icons.check : Icons.pending,
                color:
                    pembayaran.status == 'Lunas' ? Colors.green : Colors.orange,
              ),
            ),
            title: Text(pembayaran.nama),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatCurrency.format(pembayaran.jumlah)),
                Text(
                  '${DateFormat('dd MMM yyyy').format(pembayaran.tanggal)} - ${pembayaran.status}',
                  style: TextStyle(
                    color:
                        pembayaran.status == 'Lunas'
                            ? Colors.green
                            : Colors.orange,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Show payment details
            },
          ),
        );
      },
    );
  }

  Widget _buildExpensesTab(Proyek proyek, NumberFormat formatCurrency) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: proyek.pengeluaran.length,
      itemBuilder: (context, index) {
        final pengeluaran = proyek.pengeluaran[index];
        return ExpansionTile(
          title: Text(
            pengeluaran.kategori,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(formatCurrency.format(pengeluaran.jumlah)),
          children: [
            ...pengeluaran.items.map((item) {
              return ListTile(
                contentPadding: const EdgeInsets.only(left: 32, right: 16),
                leading: const Icon(Icons.circle, size: 8),
                title: Text(item.nama),
                trailing: Text(formatCurrency.format(item.jumlah)),
              );
            }),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

// Model classes
class Proyek {
  final String nama;
  final String lokasi;
  final DateTime mulai;
  final DateTime selesai;
  final double anggaran;
  final double terpakai;
  final int progres;
  final List<Pembayaran> pembayaran;
  final List<Pengeluaran> pengeluaran;

  Proyek({
    required this.nama,
    required this.lokasi,
    required this.mulai,
    required this.selesai,
    required this.anggaran,
    required this.terpakai,
    required this.progres,
    required this.pembayaran,
    required this.pengeluaran,
  });
}

class Pembayaran {
  final String nama;
  final double jumlah;
  final DateTime tanggal;
  final String status;

  Pembayaran({
    required this.nama,
    required this.jumlah,
    required this.tanggal,
    required this.status,
  });
}

class Pengeluaran {
  final String kategori;
  final double jumlah;
  final List<ItemPengeluaran> items;

  Pengeluaran({
    required this.kategori,
    required this.jumlah,
    required this.items,
  });
}

class ItemPengeluaran {
  final String nama;
  final double jumlah;

  ItemPengeluaran({required this.nama, required this.jumlah});
}
