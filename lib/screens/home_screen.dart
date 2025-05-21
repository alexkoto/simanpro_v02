import 'package:flutter/material.dart';
import 'package:simanpro_v02/screens/hrd/absensiOnline_screen.dart';
import 'package:simanpro_v02/screens/dashbord/alert_system_screen.dart';
import 'package:simanpro_v02/screens/dashbord/financial_overview_screen.dart';
import 'package:simanpro_v02/screens/hrd/skill_matrix_screen.dart';
import 'package:simanpro_v02/screens/hrd/timesheet_screen.dart';
import 'package:simanpro_v02/screens/kendaraan/equipment_screen.dart';
import 'package:simanpro_v02/screens/kendaraan/equipment_tracking_screen.dart';
import 'package:simanpro_v02/screens/kendaraan/fuel_monitoring_screen.dart';
import 'package:simanpro_v02/screens/kendaraan/maintenance_log_screen.dart';
import 'package:simanpro_v02/screens/manajemenProyek/daftar_proyek_screen.dart';
import 'package:simanpro_v02/screens/manajemenProyek/document_control_screen.dart';
import 'package:simanpro_v02/screens/material_inventory/pengembalian_material_screen.dart';
import 'package:simanpro_v02/screens/material_inventory/penggunaan_material_screen.dart';
import 'package:simanpro_v02/screens/material_inventory/purchase_order_screen.dart';
import 'package:simanpro_v02/screens/dashbord/ringkasan_proyek_screen.dart';
import 'package:simanpro_v02/screens/material_inventory/stock_management_screen.dart';
import 'package:simanpro_v02/screens/manajemenProyek/timeline_scheduling_screen.dart';
import 'package:simanpro_v02/screens/qcs/audit_qc_screen.dart';
import 'package:simanpro_v02/screens/qcs/inspeksi_harian_screen.dart';
import 'package:simanpro_v02/screens/qcs/laporan_insiden_screen.dart';

import 'notification_screen.dart';
import 'setting_screen.dart';
import 'user_screen.dart';
import 'placeholder_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _dashboardItems = [
    {'title': 'Ringkasan Proyek', 'icon': Icons.dashboard_outlined},
    {'title': 'Financial Overview', 'icon': Icons.bar_chart_outlined},
    {'title': 'Alert System', 'icon': Icons.notification_important_outlined},
  ];

  final List<Map<String, dynamic>> _projectManagementItems = [
    {'title': 'Daftar Proyek', 'icon': Icons.list},
    {'title': 'Timeline & Scheduling', 'icon': Icons.timeline},
    {'title': 'Document Control', 'icon': Icons.folder_open},
  ];

  final List<Map<String, dynamic>> _materialItems = [
    {'title': 'Stock Management', 'icon': Icons.inventory},
    {'title': 'Purchase Order', 'icon': Icons.shopping_bag_outlined},
    {'title': 'Penggunaan Material', 'icon': Icons.build},
    {'title': 'Pengembalian Material', 'icon': Icons.undo_outlined},
  ];

  final List<Map<String, dynamic>> _kendaraanItems = [
    {'title': 'Equipment', 'icon': Icons.car_rental_sharp},
    {'title': 'Equipment Tracking', 'icon': Icons.location_searching},
    {'title': 'Maintenance Log', 'icon': Icons.build_circle},
    {'title': 'Fuel Monitoring', 'icon': Icons.local_gas_station},
    {'title': 'Peminjaman Kendaraan', 'icon': Icons.directions_car_filled},
    {'title': 'Jatuh Tempo Pajak & Perizinan', 'icon': Icons.event_note},
  ];

  final List<Map<String, dynamic>> _hrItems = [
    {'title': 'Absensi Online', 'icon': Icons.fingerprint},
    {'title': 'Skill Matrix', 'icon': Icons.grid_view},
    {'title': 'Timesheet', 'icon': Icons.schedule_outlined},
  ];

  final List<Map<String, dynamic>> _qcItems = [
    {'title': 'Inspeksi Harian', 'icon': Icons.task_alt},
    {'title': 'Laporan Insiden', 'icon': Icons.report_gmailerrorred_outlined},
    {'title': 'Audit QC', 'icon': Icons.fact_check_outlined},
  ];

  final List<Map<String, dynamic>> _accountingItems = [
    {'title': 'Progress Billing', 'icon': Icons.receipt},
    {'title': 'Biaya Operasional', 'icon': Icons.money_off},
    {'title': 'Invoice Management', 'icon': Icons.request_page},
  ];

  final List<Map<String, dynamic>> _reportItems = [
    {'title': 'Daily Report', 'icon': Icons.article_outlined},
    {'title': 'Laporan Bulanan', 'icon': Icons.calendar_month},
    {'title': 'Arsip Digital', 'icon': Icons.archive_outlined},
  ];

  final List<Map<String, dynamic>> _fieldAppItems = [
    {'title': 'Photo Documentation', 'icon': Icons.photo_camera},
    {'title': 'Offline Mode', 'icon': Icons.cloud_off},
    {'title': 'Signature Capture', 'icon': Icons.edit_note},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToScreen(
    Widget screen, {
    bool updateSelected = false,
    int? indexToSet,
  }) {
    if (updateSelected && indexToSet != null) {
      setState(() {
        _selectedIndex = indexToSet;
      });
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _getScreenByTitle(String title) {
    switch (title) {
      case 'Ringkasan Proyek':
        return const RingkasanProyekScreen();
      case 'Financial Overview':
        return const FinancialOverviewScreen();
      case 'Alert System':
        return const AlertSystemScreen();
      case 'Document Control':
        return const DocumentControlScreen();
      case 'Daftar Proyek':
        return const DaftarProyekScreen();
      case 'Timeline & Scheduling':
        return TimelineSchedulingScreen();
      case 'Jadwal':
        return PlaceholderScreen(title: title);
      case 'Stock Management':
        return StockManagementScreen();
      case 'Purchase Order':
        return PurchaseOrderScreen();
      case 'Penggunaan Material':
        return PenggunaanMaterialScreen();
      case 'Pengembalian Material':
        return PengembalianMaterialScreen();
      case 'Equipment':
        return EquipmentScreen();
      case 'Equipment Tracking':
        return EquipmentTrackingScreen();

      case 'Maintenance Log':
        return MaintenanceLogScreen();
      case 'Fuel Monitoring':
        return FuelMonitoringScreen();
      case 'Peminjaman Kendaraan':
        return PlaceholderScreen(title: title);
      case 'Jatuh Tempo Pajak & Perizinan':
        return PlaceholderScreen(title: title);
      case 'Absensi Online':
        return AbsensiOnline();
      case 'Skill Matrix':
        return SkillMatrixScreen();
      case 'Timesheet':
        return TimesheetScreen();
      case 'Inspeksi Harian':
        return InspeksiHarianScreen();
      case 'Laporan Insiden':
        return LaporanInsidenScreen();
      case 'Audit QC':
        return AuditQCScreen();
      case 'Progress Billing':
        return PlaceholderScreen(title: title);
      case 'Biaya Operasional':
        return PlaceholderScreen(title: title);
      case 'Invoice Management':
        return PlaceholderScreen(title: title);
      case 'Daily Report':
        return PlaceholderScreen(title: title);
      case 'Laporan Bulanan':
        return PlaceholderScreen(title: title);
      case 'Arsip Digital':
        return PlaceholderScreen(title: title);
      case 'Photo Documentation':
        return PlaceholderScreen(title: title);
      case 'Offline Mode':
        return PlaceholderScreen(title: title);
      case 'Signature Capture':
        return PlaceholderScreen(title: title);
      case 'Timeline':
        return PlaceholderScreen(title: title);
      // Tambah sesuai kebutuhan...
      default:
        return PlaceholderScreen(title: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 8),
            Text('Hai Azka!', style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
              size: 20,
            ),
            onPressed:
                () => _navigateToScreen(
                  const NotificationScreen(),
                  updateSelected: true,
                  indexToSet: 1,
                ),
          ),
          IconButton(
            icon: const Icon(Icons.warning, color: Colors.red, size: 20),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionCard('Dashboard & Analytics', _dashboardItems),
            _buildSectionCard('Manajemen Proyek', _projectManagementItems),
            _buildSectionCard('Material & Inventory', _materialItems),
            _buildSectionCard('Alat Berat & Kendaraan', _kendaraanItems),
            _buildSectionCard('Tenaga Kerja (HRD & Lapangan)', _hrItems),
            _buildSectionCard('Quality Control & Safety', _qcItems),
            _buildSectionCard('Accounting & Finance', _accountingItems),
            _buildSectionCard('Laporan & Dokumentasi', _reportItems),
            _buildSectionCard('Mobile Field Apps', _fieldAppItems),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 24,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const NotificationScreen(),
                      updateSelected: true,
                      indexToSet: 1,
                    ),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 24,
                  color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const SettingScreen(),
                      updateSelected: true,
                      indexToSet: 2,
                    ),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
                ),
                onPressed:
                    () => _navigateToScreen(
                      const UserScreen(),
                      updateSelected: true,
                      indexToSet: 3,
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Fitur absensi atau lainnya
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.fingerprint, color: Colors.white, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Map<String, dynamic>> items) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Column(
        children: [_buildSectionTitle(title), _buildGridSection(items)],
      ),
    );
  }

  Widget _buildGridSection(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(items[index]);
      },
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _getScreenByTitle(item['title']),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(item['icon'], color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              item['title'],
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
