import 'package:flutter/material.dart';
import 'daily_report_form.dart';

class DailyReportScreen extends StatefulWidget {
  const DailyReportScreen({super.key});

  @override
  State<DailyReportScreen> createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen> {
  final List<Map<String, dynamic>> _reports = [];

  void _addNewReport(Map<String, dynamic> report) {
    setState(() {
      _reports.add(report);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Harian')),
      body:
          _reports.isEmpty
              ? const Center(child: Text('Belum ada laporan.'))
              : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _reports.length,
                itemBuilder: (ctx, index) {
                  final report = _reports[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report['project'] ?? 'Proyek Tidak Diketahui',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '📅 ${report['date']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text('🌤️ Cuaca: ${report['weather']}'),
                          const Divider(height: 16),
                          const Text(
                            '🛠️ Pekerjaan:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...List<Widget>.from(
                            (report['jobs'] ?? []).map(
                              (job) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text(
                                  '- ${job['name']} (${job['qty']} ${job['unit']})',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '👷 Tenaga Kerja:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...List<Widget>.from(
                            (report['labor'] ?? []).map(
                              (lab) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text('- ${lab['name']} (${lab['qty']})'),
                              ),
                            ),
                          ),
                          if (report['photo'] != null) ...[
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(report['photo'], height: 120),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (_) => const DailyReportForm(),
          );
          if (result != null) _addNewReport(result);
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Laporan'),
      ),
    );
  }
}
