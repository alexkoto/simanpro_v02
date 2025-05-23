import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ExportService {
  static Future<void> exportToPDF(
    BuildContext context,
    List<Map<String, dynamic>> projects,
    DateTime selectedMonth,
  ) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 5);
    grid.headers.add(1);
    final header = grid.headers[0];
    header.cells[0].value = 'Proyek';
    header.cells[1].value = 'Pekerjaan';
    header.cells[2].value = 'Qty';
    header.cells[3].value = 'Realisasi';
    header.cells[4].value = 'Target';

    for (final project in projects) {
      for (final task in project['tasks']) {
        final row = grid.rows.add();
        row.cells[0].value = project['name'];
        row.cells[1].value = task['name'];
        row.cells[2].value = '${task['qty']}';
        row.cells[3].value = '${task['realisasi']}';
        row.cells[4].value = task['target'];
      }
    }

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 0, 0, 0));
    final List<int> bytes = document.save() as List<int>;
    document.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Laporan_Bulanan.pdf');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(file.path);
  }

  static Future<void> exportToExcel(
    BuildContext context,
    List<Map<String, dynamic>> projects,
    DateTime selectedMonth,
  ) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1:E1').setText('Laporan Bulanan');
    sheet.getRangeByName('A2').setText('Proyek');
    sheet.getRangeByName('B2').setText('Pekerjaan');
    sheet.getRangeByName('C2').setText('Qty');
    sheet.getRangeByName('D2').setText('Realisasi');
    sheet.getRangeByName('E2').setText('Target');

    int row = 3;
    for (final project in projects) {
      for (final task in project['tasks']) {
        sheet.getRangeByName('A$row').setText(project['name']);
        sheet.getRangeByName('B$row').setText(task['name']);
        sheet.getRangeByName('C$row').setNumber(task['qty'].toDouble());
        sheet.getRangeByName('D$row').setNumber(task['realisasi'].toDouble());
        sheet.getRangeByName('E$row').setText(task['target']);
        row++;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Laporan_Bulanan.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(file.path);
  }
}
