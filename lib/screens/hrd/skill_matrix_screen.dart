import 'package:flutter/material.dart';
import 'package:simanpro_v02/components/custom_appbar.dart';

class SkillMatrixScreen extends StatefulWidget {
  const SkillMatrixScreen({super.key});

  @override
  State<SkillMatrixScreen> createState() => _SkillMatrixScreenState();
}

class _SkillMatrixScreenState extends State<SkillMatrixScreen> {
  final List<Map<String, String>> _skills = [
    {'name': 'Andi', 'skill': 'Welding'},
    {'name': 'Budi', 'skill': 'Electrical'},
    {'name': 'Citra', 'skill': 'Quality Control'},
    {'name': 'Doni', 'skill': 'Civil Engineer'},
    {'name': 'Eka', 'skill': 'Surveyor'},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

  void _addSkill() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Tambah Skill Baru'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _skillController,
                  decoration: const InputDecoration(labelText: 'Keahlian'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _nameController.clear();
                  _skillController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _skillController.text.isNotEmpty) {
                    setState(() {
                      _skills.add({
                        'name': _nameController.text,
                        'skill': _skillController.text,
                      });
                    });
                    _nameController.clear();
                    _skillController.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Skill Matrix'),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _skills.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _skills[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: Text(item['name'] ?? ''),
              subtitle: Text('Keahlian: ${item['skill']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _skills.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSkill,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Skill'),
      ),
    );
  }
}
