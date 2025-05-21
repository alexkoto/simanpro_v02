import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class PenggunaanMaterialScreen extends StatefulWidget {
  const PenggunaanMaterialScreen({super.key});

  @override
  State<PenggunaanMaterialScreen> createState() =>
      _PenggunaanMaterialScreenState();
}

class _PenggunaanMaterialScreenState extends State<PenggunaanMaterialScreen> {
  final Map<String, List<Map<String, dynamic>>> _penggunaanPerProyek = {
    'Proyek A - Gedung Serbaguna': [
      {
        'material': 'Semen',
        'jumlah': 30,
        'satuan': 'sak',
        'tanggal': '2025-05-10',
        'kategori': 'Material Bangunan',
        'lokasi': 'Lantai 3',
        'penanggung_jawab': 'Budi Santoso',
        'keterangan': 'Pengecoran kolom',
        'foto': 'foto1.jpg',
      },
      {
        'material': 'Besi Beton',
        'jumlah': 40,
        'satuan': 'batang',
        'tanggal': '2025-05-11',
        'kategori': 'Material Bangunan',
        'lokasi': 'Lantai 2',
        'penanggung_jawab': 'Ahmad Fauzi',
        'keterangan': 'Pembesian balok',
        'foto': 'foto2.jpg',
      },
      {
        'material': 'Cat Tembok',
        'jumlah': 15,
        'satuan': 'kaleng',
        'tanggal': '2025-05-12',
        'kategori': 'Finishing',
        'lokasi': 'Lantai 1',
        'penanggung_jawab': 'Dewi Anggraeni',
        'keterangan': 'Finishing ruang meeting',
        'foto': 'foto3.jpg',
      },
    ],
    'Proyek B - Jalan Desa': [
      {
        'material': 'Paku',
        'jumlah': 1000,
        'satuan': 'gram',
        'tanggal': '2025-05-11',
        'kategori': 'Material Pendukung',
        'lokasi': 'KM 1-2',
        'penanggung_jawab': 'Joko Prasetyo',
        'keterangan': 'Pemasangan papan nama',
        'foto': 'foto4.jpg',
      },
      {
        'material': 'Aspal',
        'jumlah': 200,
        'satuan': 'kg',
        'tanggal': '2025-05-13',
        'kategori': 'Material Jalan',
        'lokasi': 'KM 2-3',
        'penanggung_jawab': 'Rudi Hermawan',
        'keterangan': 'Penambalan lubang',
        'foto': 'foto5.jpg',
      },
    ],
  };

  String _selectedProject = '';
  String _searchQuery = '';
  DateTimeRange? _dateRange;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _selectedProject = _penggunaanPerProyek.keys.first;
  }

  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> data = [];

    // Filter by selected project
    if (_penggunaanPerProyek.containsKey(_selectedProject)) {
      data = List.from(_penggunaanPerProyek[_selectedProject]!);
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      data =
          data
              .where(
                (item) =>
                    item['material'].toString().toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    item['keterangan'].toString().toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    item['penanggung_jawab'].toString().toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();
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

  void _showMaterialDetails(Map<String, dynamic> material) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Detail Penggunaan Material'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow('Material', material['material']),
                  _buildDetailRow(
                    'Jumlah',
                    '${material['jumlah']} ${material['satuan']}',
                  ),
                  _buildDetailRow(
                    'Tanggal',
                    _dateFormat.format(DateTime.parse(material['tanggal'])),
                  ),
                  _buildDetailRow('Lokasi', material['lokasi']),
                  _buildDetailRow(
                    'Penanggung Jawab',
                    material['penanggung_jawab'],
                  ),
                  _buildDetailRow('Kategori', material['kategori']),
                  _buildDetailRow('Keterangan', material['keterangan']),
                  const SizedBox(height: 16),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/${material['foto']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.photo_camera,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                  // TODO: Implement edit functionality
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
            width: 120,
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

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Penggunaan Material',
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: null, // TODO: Implement analytics
            tooltip: 'Analisis Penggunaan',
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
                            _penggunaanPerProyek.keys.map((String value) {
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
                    hintText: 'Cari material...',
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
                            Text(
                              'Total Penggunaan: ${filteredData.length} material',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
                              Colors.brown.shade50,
                            ),
                            columns: const [
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('Material')),
                              DataColumn(
                                label: Text(
                                  'Jumlah',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataColumn(label: Text('Tanggal')),
                              DataColumn(label: Text('Lokasi')),
                              DataColumn(label: Text('PJ')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            rows: List<DataRow>.generate(filteredData.length, (
                              index,
                            ) {
                              final item = filteredData[index];
                              return DataRow(
                                color:
                                    WidgetStateProperty.resolveWith<Color?>((
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
                                    Text(item['material']),
                                    onTap: () => _showMaterialDetails(item),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        '${item['jumlah']} ${item['satuan']}',
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      _dateFormat.format(
                                        DateTime.parse(item['tanggal']),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(item['lokasi'])),
                                  DataCell(Text(item['penanggung_jawab'])),
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
                                              () => _showMaterialDetails(item),
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
          // TODO: Implement add material usage
        },
        tooltip: 'Tambah Penggunaan Material',
        child: const Icon(Icons.add),
      ),
    );
  }
}
