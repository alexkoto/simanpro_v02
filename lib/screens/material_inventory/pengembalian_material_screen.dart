import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';
import 'package:simanpro_v02/screens/material_inventory/form_pengembalian_material.dart';

class PengembalianMaterialScreen extends StatefulWidget {
  const PengembalianMaterialScreen({super.key});

  @override
  State<PengembalianMaterialScreen> createState() =>
      _PengembalianMaterialScreenState();
}

class _PengembalianMaterialScreenState
    extends State<PengembalianMaterialScreen> {
  final Map<String, List<Map<String, dynamic>>> _pengembalianPerProyek = {
    'Proyek A - Gedung Serbaguna': [
      {
        'material': 'Besi Beton',
        'jumlah': 10,
        'satuan': 'batang',
        'tanggal': '2025-05-12',
        'penerima': 'Budi Santoso',
        'penyerah': 'Ahmad Fauzi',
        'kondisi': 'Baik',
        'keterangan': 'Sisa proyek lantai 3',
        'no_dokumen': 'RET-2025-001',
        'foto': 'return1.jpg',
      },
      {
        'material': 'Paku',
        'jumlah': 500,
        'satuan': 'gram',
        'tanggal': '2025-05-13',
        'penerima': 'Budi Santoso',
        'penyerah': 'Dewi Anggraeni',
        'kondisi': 'Rusak 5%',
        'keterangan': 'Sisa pemasangan plafon',
        'no_dokumen': 'RET-2025-002',
        'foto': 'return2.jpg',
      },
    ],
    'Proyek B - Jalan Desa': [
      {
        'material': 'Semen',
        'jumlah': 5,
        'satuan': 'sak',
        'tanggal': '2025-05-13',
        'penerima': 'Rina Wijaya',
        'penyerah': 'Joko Prasetyo',
        'kondisi': 'Baik',
        'keterangan': 'Sisa pengecoran jalan',
        'no_dokumen': 'RET-2025-003',
        'foto': 'return3.jpg',
      },
      {
        'material': 'Aspal',
        'jumlah': 50,
        'satuan': 'kg',
        'tanggal': '2025-05-14',
        'penerima': 'Rina Wijaya',
        'penyerah': 'Rudi Hermawan',
        'kondisi': 'Baik',
        'keterangan': 'Sisa penambalan',
        'no_dokumen': 'RET-2025-004',
        'foto': 'return4.jpg',
      },
    ],
  };

  String _selectedProject = '';
  String _searchQuery = '';
  DateTimeRange? _dateRange;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedProject = _pengembalianPerProyek.keys.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> data = [];

    // Filter by selected project
    if (_pengembalianPerProyek.containsKey(_selectedProject)) {
      data = List.from(_pengembalianPerProyek[_selectedProject]!);
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      data =
          data.where((item) {
            final lowerSearchQuery = _searchQuery.toLowerCase();
            return item['material'].toString().toLowerCase().contains(
                  lowerSearchQuery,
                ) ||
                item['no_dokumen'].toString().toLowerCase().contains(
                  lowerSearchQuery,
                ) ||
                item['penyerah'].toString().toLowerCase().contains(
                  lowerSearchQuery,
                ) ||
                item['penerima'].toString().toLowerCase().contains(
                  lowerSearchQuery,
                );
          }).toList();
    }

    // Apply date range filter
    if (_dateRange != null) {
      data =
          data.where((item) {
            final itemDate = DateTime.parse(item['tanggal']);
            return itemDate.isAfter(
                  _dateRange!.start.subtract(const Duration(days: 1)),
                ) &&
                itemDate.isBefore(_dateRange!.end.add(const Duration(days: 1)));
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
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _showReturnDetails(Map<String, dynamic> returnItem) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.assignment_returned,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Detail Pengembalian',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailCard(
                          title: 'Informasi Material',
                          children: [
                            _buildDetailRow('Material', returnItem['material']),
                            _buildDetailRow(
                              'Jumlah',
                              '${returnItem['jumlah']} ${returnItem['satuan']}',
                            ),
                            _buildDetailRow('Kondisi', returnItem['kondisi']),
                            _buildDetailRow(
                              'Keterangan',
                              returnItem['keterangan'],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailCard(
                          title: 'Informasi Dokumen',
                          children: [
                            _buildDetailRow(
                              'No. Dokumen',
                              returnItem['no_dokumen'],
                            ),
                            _buildDetailRow(
                              'Tanggal',
                              _dateFormat.format(
                                DateTime.parse(returnItem['tanggal']),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailCard(
                          title: 'Informasi Personil',
                          children: [
                            _buildDetailRow('Penyerah', returnItem['penyerah']),
                            _buildDetailRow('Penerima', returnItem['penerima']),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailCard(
                          title: 'Bukti Pengembalian',
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/${returnItem['foto']}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('TUTUP'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement print function
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Mencetak dokumen pengembalian...',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('CETAK'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
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

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'baik':
        return Colors.green;
      case 'rusak <10%':
        return Colors.yellowAccent;
      case 'rusak 10-30%':
        return Colors.orange.shade700;
      case 'rusak >30%':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _getFilteredData();
    final totalItems = filteredData.fold(
      0,
      (sum, item) => sum + (item['jumlah'] as int),
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pengembalian Material',
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: null, // TODO: Implement bulk print
            tooltip: 'Cetak Laporan',
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
                          filled: true,
                          fillColor: Colors.blue.shade100,
                        ),
                        items:
                            _pengembalianPerProyek.keys.map((String value) {
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
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari material, no dokumen, atau penerima...',
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ${filteredData.length} pengembalian',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Jumlah Material: $totalItems item',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 24,
                      headingRowColor: WidgetStateProperty.all(
                        Colors.blue.shade100,
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'No',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Material',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Jumlah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Kondisi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tanggal',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'No. Dokumen',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Penyerah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Aksi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                              Text(item['material']),
                              onTap: () => _showReturnDetails(item),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  '${item['jumlah']} ${item['satuan']}',
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getConditionColor(
                                    item['kondisi'],
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getConditionColor(item['kondisi']),
                                  ),
                                ),
                                child: Text(
                                  item['kondisi'],
                                  style: TextStyle(
                                    color: _getConditionColor(item['kondisi']),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            DataCell(Text(item['no_dokumen'])),
                            DataCell(Text(item['penyerah'])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      size: 20,
                                    ),
                                    color: Colors.blue,
                                    onPressed: () => _showReturnDetails(item),
                                    tooltip: 'Detail',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.print, size: 20),
                                    color: Colors.blue,
                                    onPressed: () {
                                      // TODO: Implement single print
                                    },
                                    tooltip: 'Cetak',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormPengembalianMaterial(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Tambah Pengembalian',
        child: const Icon(Icons.add),
      ),
    );
  }
}
