import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ArsipDigitalScreen extends StatefulWidget {
  const ArsipDigitalScreen({super.key});

  @override
  State<ArsipDigitalScreen> createState() => _ArsipDigitalScreenState();
}

class _ArsipDigitalScreenState extends State<ArsipDigitalScreen> {
  String selectedCategory = 'Semua';
  String searchQuery = '';

  final List<String> categories = [
    'Semua',
    'Dokumen Kontrak',
    'As-built Drawing',
    'Berita Acara',
    'Dokumen Lainnya',
  ];

  final List<String> projects = ['Proyek A', 'Proyek B'];

  final List<Map<String, String>> allDocuments = [
    {
      'project': 'Proyek A',
      'category': 'As-built Drawing',
      'name': 'Gambar Kabel 1',
    },
    {
      'project': 'Proyek A',
      'category': 'Berita Acara',
      'name': 'Berita Acara Pemeriksaan',
    },
    {
      'project': 'Proyek B',
      'category': 'As-built Drawing',
      'name': 'Skema Panel',
    },
    {
      'project': 'Proyek B',
      'category': 'Dokumen Kontrak',
      'name': 'SPK Kontrak 123.spk',
    },
  ];

  List<Map<String, String>> get filteredDocuments {
    return allDocuments.where((doc) {
      final matchesCategory =
          selectedCategory == 'Semua' || doc['category'] == selectedCategory;
      final matchesSearch = doc['name']!.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _addDocument() async {
    String? selectedProject = projects.first;
    String? selectedDocCategory = categories[1];
    String? fileName;

    PlatformFile? selectedFile;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Tambah Dokumen'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedProject,
                      items:
                          projects
                              .map(
                                (proj) => DropdownMenuItem(
                                  value: proj,
                                  child: Text(proj),
                                ),
                              )
                              .toList(),
                      decoration: const InputDecoration(labelText: 'Proyek'),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedProject = value;
                        });
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedDocCategory,
                      items:
                          categories
                              .where((e) => e != 'Semua')
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                      decoration: const InputDecoration(labelText: 'Kategori'),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedDocCategory = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Pilih File'),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          setStateDialog(() {
                            selectedFile = result.files.first;
                            fileName = selectedFile!.name;
                          });
                        }
                      },
                    ),
                    if (fileName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'File: $fileName',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text('Simpan'),
                  onPressed: () {
                    if (selectedFile != null &&
                        selectedProject != null &&
                        selectedDocCategory != null) {
                      setState(() {
                        allDocuments.add({
                          'project': selectedProject!,
                          'category': selectedDocCategory!,
                          'name': fileName!,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arsip Digital')),
      body: Column(
        children: [
          // Filter kategori
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  categories.map((cat) {
                    final isSelected = cat == selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),
          // Pencarian
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari dokumen...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Daftar dokumen
          Expanded(
            child: ListView.builder(
              itemCount: filteredDocuments.length,
              itemBuilder: (context, index) {
                final doc = filteredDocuments[index];
                return ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(doc['name']!),
                  subtitle: Text('${doc['project']} - ${doc['category']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mengunduh ${doc['name']}')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDocument,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Dokumen',
      ),
    );
  }
}
