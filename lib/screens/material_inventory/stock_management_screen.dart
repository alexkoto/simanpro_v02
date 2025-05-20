import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({Key? key}) : super(key: key);

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final Map<String, List<Map<String, dynamic>>> _stokPerProyek = {
    'Proyek A - Gedung Serbaguna': [
      {
        'nama': 'Semen',
        'jumlah': 120,
        'satuan': 'sak',
        'min_stok': 50,
        'kategori': 'Material Bangunan',
        'supplier': 'PT Semen Indonesia',
        'update_terakhir': '2023-05-15',
      },
      {
        'nama': 'Besi Beton',
        'jumlah': 250,
        'satuan': 'batang',
        'min_stok': 100,
        'kategori': 'Material Bangunan',
        'supplier': 'PT Krakatau Steel',
        'update_terakhir': '2023-05-10',
      },
      {
        'nama': 'Cat Tembok',
        'jumlah': 35,
        'satuan': 'kaleng',
        'min_stok': 20,
        'kategori': 'Finishing',
        'supplier': 'PT Avian Brands',
        'update_terakhir': '2023-05-18',
      },
    ],
    'Proyek B - Jalan Desa': [
      {
        'nama': 'Batu Bata',
        'jumlah': 1000,
        'satuan': 'buah',
        'min_stok': 500,
        'kategori': 'Material Bangunan',
        'supplier': 'UD Sumber Bata',
        'update_terakhir': '2023-05-12',
      },
      {
        'nama': 'Paku',
        'jumlah': 3000,
        'satuan': 'gram',
        'min_stok': 1000,
        'kategori': 'Material Pendukung',
        'supplier': 'PT Paku Mas',
        'update_terakhir': '2023-05-14',
      },
      {
        'nama': 'Aspal',
        'jumlah': 500,
        'satuan': 'kg',
        'min_stok': 200,
        'kategori': 'Material Jalan',
        'supplier': 'PT Pertamina',
        'update_terakhir': '2023-05-16',
      },
    ],
    'Proyek C - Penerangan': [
      {
        'nama': 'Kabel NYY',
        'jumlah': 500,
        'satuan': 'meter',
        'min_stok': 200,
        'kategori': 'Material Listrik',
        'supplier': 'PT Kabelindo',
        'update_terakhir': '2023-05-11',
      },
      {
        'nama': 'Tiang Besi',
        'jumlah': 15,
        'satuan': 'buah',
        'min_stok': 5,
        'kategori': 'Material Listrik',
        'supplier': 'PT Tiang Listrik Nusantara',
        'update_terakhir': '2023-05-09',
      },
      {
        'nama': 'Lampu LED',
        'jumlah': 45,
        'satuan': 'buah',
        'min_stok': 20,
        'kategori': 'Material Listrik',
        'supplier': 'PT Philips Indonesia',
        'update_terakhir': '2023-05-17',
      },
    ],
  };

  String _formatDate(String dateString) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(dateString));
  }

  Color _getStockStatusColor(int current, int min) {
    return current < min ? Colors.red.shade300 : Colors.green.shade300;
  }

  void _showMaterialDetails(Map<String, dynamic> material) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Detail Material: ${material['nama']}'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow(
                    'Jumlah',
                    '${material['jumlah']} ${material['satuan']}',
                  ),
                  _buildDetailRow(
                    'Stok Minimum',
                    '${material['min_stok']} ${material['satuan']}',
                  ),
                  _buildDetailRow('Kategori', material['kategori']),
                  _buildDetailRow('Supplier', material['supplier']),
                  _buildDetailRow(
                    'Update Terakhir',
                    _formatDate(material['update_terakhir']),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: material['jumlah'] / (material['min_stok'] * 3),
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStockStatusColor(
                        material['jumlah'],
                        material['min_stok'],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Persediaan: ${(material['jumlah'] / material['min_stok'] * 100).toStringAsFixed(0)}% dari minimum',
                      style: TextStyle(
                        color: _getStockStatusColor(
                          material['jumlah'],
                          material['min_stok'],
                        ),
                        fontWeight: FontWeight.bold,
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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Manajemen Stok Material',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null, // TODO: Implement search
            tooltip: 'Cari Material',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari proyek atau material...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      // TODO: Implement search functionality
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    // TODO: Implement filter functionality
                  },
                  tooltip: 'Filter',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children:
                  _stokPerProyek.entries.map((entry) {
                    final String proyek = entry.key;
                    final List<Map<String, dynamic>> daftarMaterial =
                        entry.value;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 24),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.construction,
                                  color: Colors.deepPurple,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    proyek,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    '${daftarMaterial.length} material',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.deepPurple.shade50,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 24,
                              headingRowColor: MaterialStateProperty.all(
                                Colors.deepPurple.shade50,
                              ),
                              columns: const [
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('Nama Material')),
                                DataColumn(
                                  label: Text(
                                    'Jumlah',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Min Stok',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Aksi')),
                              ],
                              rows: List<
                                DataRow
                              >.generate(daftarMaterial.length, (index) {
                                final material = daftarMaterial[index];
                                final isLowStock =
                                    material['jumlah'] < material['min_stok'];

                                return DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (index.isEven) {
                                            return Colors.grey.shade50;
                                          }
                                          return null;
                                        },
                                      ),
                                  cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(
                                      Text(material['nama']),
                                      onTap:
                                          () => _showMaterialDetails(material),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          '${material['jumlah']} ${material['satuan']}',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          '${material['min_stok']} ${material['satuan']}',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStockStatusColor(
                                            material['jumlah'],
                                            material['min_stok'],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          isLowStock ? 'RENDAH' : 'AMAN',
                                          style: TextStyle(
                                            color:
                                                isLowStock
                                                    ? Colors.red.shade900
                                                    : Colors.green.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                                () => _showMaterialDetails(
                                                  material,
                                                ),
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
                                              Icons.inventory_2,
                                              size: 20,
                                            ),
                                            color: Colors.green,
                                            onPressed: () {
                                              // TODO: Implement restock
                                            },
                                            tooltip: 'Restock',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Update terakhir: ${_formatDate(daftarMaterial.first['update_terakhir'])}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Tambah Material'),
                                  onPressed: () {
                                    // TODO: Implement add material
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add project
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Proyek Baru',
      ),
    );
  }
}
