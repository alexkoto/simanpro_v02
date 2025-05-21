import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimesheetScreen extends StatefulWidget {
  const TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  final List<Map<String, dynamic>> _timesheetData = [];

  void _showAddTimesheetDialog() {
    final TextEditingController activityController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Timesheet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: activityController,
                decoration: const InputDecoration(labelText: 'Aktivitas'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Tanggal: "),
                  Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                        Navigator.of(context).pop();
                        _showAddTimesheetDialog(); // Reopen dialog with new date
                      }
                    },
                  )
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                if (activityController.text.isNotEmpty) {
                  setState(() {
                    _timesheetData.add({
                      'activity': activityController.text,
                      'date': selectedDate,
                    });
                  });
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheet'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _timesheetData.isEmpty
          ? const Center(child: Text('Belum ada data timesheet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: _timesheetData.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final item = _timesheetData[index];
                return ListTile(
                  tileColor: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  leading: const Icon(Icons.work, color: Colors.blue),
                  title: Text(item['activity']),
                  subtitle: Text(
                    'Tanggal: ${DateFormat('dd-MM-yyyy').format(item['date'])}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTimesheetDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
