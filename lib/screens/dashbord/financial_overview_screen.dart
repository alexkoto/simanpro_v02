import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class FinancialOverviewScreen extends StatelessWidget {
  const FinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Financial Overview'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Ringkasan Keuangan Proyek',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Wrap DataTable with SingleChildScrollView and scroll horizontally
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                dataRowMinHeight: 40,
                dataRowMaxHeight: 60,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Proyek',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Anggaran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Pengeluaran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sisa Anggaran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('Proyek A')),
                      DataCell(Text('Rp 1,000,000,000')),
                      DataCell(Text('Rp 750,000,000')),
                      DataCell(Text('Rp 250,000,000')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Proyek B')),
                      DataCell(Text('Rp 500,000,000')),
                      DataCell(Text('Rp 200,000,000')),
                      DataCell(Text('Rp 300,000,000')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Proyek C')),
                      DataCell(Text('Rp 750,000,000')),
                      DataCell(Text('Rp 100,000,000')),
                      DataCell(Text('Rp 650,000,000')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildFinancialChart(),
            const SizedBox(height: 20),
            _buildExpenseBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grafik Anggaran Proyek',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Visualisasi Grafik akan Ditampilkan di Sini',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseBreakdown() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rincian Pengeluaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const IntrinsicColumnWidth(),
                border: TableBorder.all(),
                children: [
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.grey),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Kategori',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Jumlah',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Persentase',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Material'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp 500,000,000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Tenaga Kerja'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp 300,000,000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          value: 0.3,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Operasional'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Rp 200,000,000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          value: 0.1,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
