import 'package:flutter/material.dart';
import 'package:simanpro_v02/screens/laporan/export_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  DateTime _selectedMonth = DateTime.now();

  final List<Map<String, dynamic>> _projects = [
    {
      'name': 'Proyek A',
      'tasks': [
        {
          'name': 'Pemasangan Kabel',
          'qty': 100,
          'realisasi': 60,
          'target': '2025-06-15',
        },
        {
          'name': 'Instalasi Panel',
          'qty': 10,
          'realisasi': 8,
          'target': '2025-06-30',
        },
        {
          'name': 'Penggalian Tanah',
          'qty': 200,
          'realisasi': 150,
          'target': '2025-07-05',
        },
        {
          'name': 'Pengecoran Pondasi',
          'qty': 50,
          'realisasi': 30,
          'target': '2025-06-25',
        },
        {
          'name': 'Instalasi Grounding',
          'qty': 20,
          'realisasi': 18,
          'target': '2025-06-10',
        },
      ],
    },
    {
      'name': 'Proyek B',
      'tasks': [
        {
          'name': 'Pemasangan Lampu',
          'qty': 50,
          'realisasi': 50,
          'target': '2025-06-10',
        },
        {
          'name': 'Stop Kontak',
          'qty': 20,
          'realisasi': 12,
          'target': '2025-06-20',
        },
        {
          'name': 'Pipa Conduit',
          'qty': 100,
          'realisasi': 80,
          'target': '2025-06-18',
        },
        {
          'name': 'Tarik Kabel',
          'qty': 300,
          'realisasi': 220,
          'target': '2025-07-01',
        },
        {
          'name': 'Pemasangan MCB',
          'qty': 15,
          'realisasi': 15,
          'target': '2025-06-22',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    return _projects
        .map((project) {
          final filteredTasks =
              (project['tasks'] as List).where((task) {
                final taskDate = DateTime.tryParse(task['target']);
                return taskDate != null &&
                    taskDate.year == _selectedMonth.year &&
                    taskDate.month == _selectedMonth.month;
              }).toList();

          return {'name': project['name'], 'tasks': filteredTasks};
        })
        .where((project) => (project['tasks'] as List).isNotEmpty)
        .toList();
  }

  void _selectMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: 'Pilih Bulan',
      fieldHintText: 'mm/yyyy',
    );
    if (picked != null) {
      setState(() {
        _selectedMonth = DateTime(picked.year, picked.month);
      });
    }
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    final filteredTasks = project['tasks'];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ExpansionTile(
        title: Text(
          project['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Pekerjaan')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Realisasi')),
                    DataColumn(label: Text('Sisa')),
                    DataColumn(label: Text('Target')),
                  ],
                  rows: [
                    ...filteredTasks.map<DataRow>((task) {
                      final sisa = task['qty'] - task['realisasi'];
                      return DataRow(
                        cells: [
                          DataCell(Text(task['name'])),
                          DataCell(Text('${task['qty']}')),
                          DataCell(Text('${task['realisasi']}')),
                          DataCell(Text('$sisa')),
                          DataCell(Text(task['target'])),
                        ],
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Progress Pekerjaan'),
                  legend: const Legend(isVisible: true),
                  series: <CartesianSeries>[
                    ColumnSeries<Map<String, dynamic>, String>(
                      dataSource: filteredTasks,
                      xValueMapper: (task, _) => task['name'],
                      yValueMapper: (task, _) => task['realisasi'],
                      name: 'Realisasi',
                      color: Colors.green,
                    ),
                    ColumnSeries<Map<String, dynamic>, String>(
                      dataSource: filteredTasks,
                      xValueMapper: (task, _) => task['name'],
                      yValueMapper: (task, _) => task['qty'],
                      name: 'Target',
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthStr = DateFormat('MMMM yyyy').format(_selectedMonth);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Bulanan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed:
                () => ExportService.exportToPDF(
                  context,
                  _filteredProjects,
                  _selectedMonth,
                ),
          ),
          IconButton(
            icon: const Icon(Icons.table_chart),
            onPressed:
                () => ExportService.exportToExcel(
                  context,
                  _filteredProjects,
                  _selectedMonth,
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Bulan Laporan'),
            subtitle: Text(monthStr),
            trailing: IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () => _selectMonth(context),
            ),
          ),
          Expanded(
            child: ListView(
              children: _filteredProjects.map(_buildProjectCard).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
