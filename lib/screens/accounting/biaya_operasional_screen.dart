import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class BiayaOperasionalScreen extends StatefulWidget {
  const BiayaOperasionalScreen({super.key});

  @override
  State<BiayaOperasionalScreen> createState() => _BiayaOperasionalScreenState();
}

class _BiayaOperasionalScreenState extends State<BiayaOperasionalScreen> {
  final Map<String, List<Map<String, dynamic>>> _biayaPerProyek = {
    'Proyek 1 - Instalasi Listrik Ruko': [
      {
        'item': 'Kabel NYY 4x2.5mm',
        'jumlah': 150,
        'satuan': 'meter',
        'harga_satuan': 25000,
        'total': 3750000,
        'tanggal': '2025-06-10',
        'kategori': 'Material Listrik',
      },
      {
        'item': 'MCB 3 Phase',
        'jumlah': 2,
        'satuan': 'unit',
        'harga_satuan': 450000,
        'total': 900000,
        'tanggal': '2025-06-11',
        'kategori': 'Panel Listrik',
      },
      {
        'item': 'Jasa Pemasangan',
        'jumlah': 1,
        'satuan': 'paket',
        'harga_satuan': 2500000,
        'total': 2500000,
        'tanggal': '2025-06-12',
        'kategori': 'Jasa',
      },
    ],
    'Proyek 2 - PJU Tenaga Surya Desa': [
      {
        'item': 'Lampu LED Solar 30W',
        'jumlah': 20,
        'satuan': 'unit',
        'harga_satuan': 850000,
        'total': 17000000,
        'tanggal': '2025-06-15',
        'kategori': 'Penerangan',
      },
      {
        'item': 'Panel Surya 100Wp',
        'jumlah': 20,
        'satuan': 'unit',
        'harga_satuan': 1200000,
        'total': 24000000,
        'tanggal': '2025-06-15',
        'kategori': 'Solar Panel',
      },
    ],
  };

  String _selectedProject = '';
  String _searchQuery = '';
  DateTimeRange? _dateRange;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _selectedProject = _biayaPerProyek.keys.first;
  }

  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> data = [];

    // Filter by selected project
    if (_biayaPerProyek.containsKey(_selectedProject)) {
      data = List.from(_biayaPerProyek[_selectedProject]!);
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      data =
          data.where((item) {
            return item['item'].toString().toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                item['kategori'].toString().toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );
          }).toList();
    }

    // Apply date range filter
    if (_dateRange != null) {
      data =
          data.where((item) {
            final itemDate = DateTime.parse(item['tanggal']);
            return itemDate.isAfter(_dateRange!.start) &&
                itemDate.isBefore(_dateRange!.end);
          }).toList();
    }

    return data;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: _dateRange,
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _showCostDetails(Map<String, dynamic> costItem) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Detail Biaya Operasional'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow('Item', costItem['item']),
                  _buildDetailRow(
                    'Jumlah',
                    '${costItem['jumlah']} ${costItem['satuan']}',
                  ),
                  _buildDetailRow(
                    'Harga Satuan',
                    _currencyFormat.format(costItem['harga_satuan']),
                  ),
                  _buildDetailRow(
                    'Total',
                    _currencyFormat.format(costItem['total']),
                  ),
                  _buildDetailRow(
                    'Tanggal',
                    _dateFormat.format(DateTime.parse(costItem['tanggal'])),
                  ),
                  _buildDetailRow('Kategori', costItem['kategori']),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('TUTUP'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur edit akan datang')),
                  );
                },
                child: const Text('EDIT'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _getFilteredData();
    final totalCost = filteredData.fold(
      0,
      (sum, item) => sum + (item['total'] as int),
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Biaya Operasional',
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: null, // TODO: Implement analytics
            tooltip: 'Analisis Biaya',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedProject,
                        decoration: InputDecoration(
                          labelText: 'Pilih Proyek',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items:
                            _biayaPerProyek.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProject = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDateRange(context),
                      tooltip: 'Filter Tanggal',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari item biaya...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Item: ${filteredData.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Total Biaya: ${_currencyFormat.format(totalCost)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            if (_dateRange != null)
                              Text(
                                '${_dateFormat.format(_dateRange!.start)} - ${_dateFormat.format(_dateRange!.end)}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 24,
                            headingRowColor: WidgetStateProperty.all(
                              Colors.blue.shade50,
                            ),
                            columns: [
                              const DataColumn(label: Text('No')),
                              const DataColumn(label: Text('Item')),
                              const DataColumn(
                                label: Text('Jumlah'),
                                numeric: true,
                              ),
                              DataColumn(
                                label: const Text('Harga'),
                                numeric: true,
                              ),
                              DataColumn(
                                label: const Text('Total'),
                                numeric: true,
                              ),
                              const DataColumn(label: Text('Tanggal')),
                              const DataColumn(label: Text('Kategori')),
                              const DataColumn(label: Text('Aksi')),
                            ],
                            rows: List<DataRow>.generate(filteredData.length, (
                              index,
                            ) {
                              final item = filteredData[index];
                              return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>((
                                  Set<WidgetState> states,
                                ) {
                                  if (index.isEven) {
                                    return Colors.grey.shade50;
                                  }
                                  return null;
                                }),
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(
                                    Text(item['item']),
                                    onTap: () => _showCostDetails(item),
                                  ),
                                  DataCell(
                                    Text(
                                      '${item['jumlah']} ${item['satuan']}',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      _currencyFormat.format(
                                        item['harga_satuan'],
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      _currencyFormat.format(item['total']),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      _dateFormat.format(
                                        DateTime.parse(item['tanggal']),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(item['kategori'])),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                          ),
                                          color: Colors.blue,
                                          onPressed:
                                              () => _showCostDetails(item),
                                          tooltip: 'Detail',
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          color: Colors.orange,
                                          onPressed: () {
                                            // TODO: Implement edit
                                          },
                                          tooltip: 'Edit',
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          color: Colors.red,
                                          onPressed: () {
                                            // TODO: Implement delete
                                          },
                                          tooltip: 'Hapus',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add operational cost
        },
        tooltip: 'Tambah Biaya Operasional',
        child: const Icon(Icons.add),
      ),
    );
  }
}
