import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PhotoDocumentationScreen extends StatefulWidget {
  const PhotoDocumentationScreen({super.key});

  @override
  State<PhotoDocumentationScreen> createState() =>
      _PhotoDocumentationScreenState();
}

class _PhotoDocumentationScreenState extends State<PhotoDocumentationScreen> {
  final List<Map<String, dynamic>> photos = [];
  final List<String> projects = ['Proyek A', 'Proyek B', 'Proyek C'];

  String? selectedProject;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (selectedProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih proyek terlebih dahulu')),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        photos.add({
          'file': File(pickedFile.path),
          'project': selectedProject,
          'timestamp': DateTime.now(),
        });
      });
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('dd MMM yyyy – HH:mm', 'id_ID').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foto Dokumentasi')),
      body: Column(
        children: [
          // Pilih proyek
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedProject,
              hint: const Text('Pilih Proyek'),
              items:
                  projects
                      .map(
                        (proj) =>
                            DropdownMenuItem(value: proj, child: Text(proj)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProject = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Proyek',
              ),
            ),
          ),

          // Tombol upload
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.upload),
              label: const Text('Unggah Foto'),
              onPressed: _pickImage,
            ),
          ),

          // Daftar foto
          Expanded(
            child:
                photos.isEmpty
                    ? const Center(child: Text('Belum ada dokumentasi.'))
                    : ListView.builder(
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.file(
                                photo['file'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${photo['project']} – ${_formatTimestamp(photo['timestamp'])}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
