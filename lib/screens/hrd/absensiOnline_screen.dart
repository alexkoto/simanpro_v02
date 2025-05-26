import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AbsensiOnline extends StatefulWidget {
  const AbsensiOnline({super.key});

  @override
  State<AbsensiOnline> createState() => _AbsensiOnlineState();
}

class _AbsensiOnlineState extends State<AbsensiOnline> {
  File? _image;
  Position? _currentPosition;
  DateTime _currentTime = DateTime.now();
  bool _isLoading = false;
  String _statusAbsensi = "Belum Absen";
  final ImagePicker _picker = ImagePicker();
  final DateFormat _dateFormat = DateFormat('EEEE, dd MMMM yyyy');
  final DateFormat _timeFormat = DateFormat('HH:mm:ss');
  final DateFormat _fullDateTimeFormat = DateFormat('dd-MM-yyyy HH:mm:ss');

  // Lokasi absensi yang sah
  // final double _absenLatitude = 0.473228;
  // final double _absenLongitude = 101.476607;
  // final double _maxDistanceMeters = 10.0;

  final double _absenLatitude = 0.538193;
  final double _absenLongitude = 101.454417;
  final double _maxDistanceMeters = 5.0;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    _startTimeUpdates();
    await _checkAndRequestPermissions();
  }

  void _startTimeUpdates() {
    _updateTime();
  }

  void _updateTime() {
    if (mounted) {
      setState(() => _currentTime = DateTime.now());
      Future.delayed(const Duration(seconds: 1), _updateTime);
    }
  }

  Future<void> _checkAndRequestPermissions() async {
    setState(() => _isLoading = true);

    try {
      final permissions =
          await [
            Permission.camera,
            Permission.location,
            Permission.locationWhenInUse,
          ].request();

      if (permissions[Permission.camera]?.isPermanentlyDenied == true ||
          permissions[Permission.location]?.isPermanentlyDenied == true) {
        _showPermissionSettingsDialog();
        return;
      }

      await _checkLocationServiceAndPermission();
    } catch (e) {
      _showSnackBar('Error mengelola izin: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _checkLocationServiceAndPermission() async {
    final isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      _showLocationServiceDialog();
      return;
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestedPermission = await Geolocator.requestPermission();
      if (requestedPermission != LocationPermission.whileInUse &&
          requestedPermission != LocationPermission.always) {
        _showPermissionSettingsDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionSettingsDialog();
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );

      if (mounted) {
        setState(() => _currentPosition = position);
      }
    } catch (e) {
      _showSnackBar('Gagal mendapatkan lokasi: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
        maxWidth: 1080,
      );

      if (image != null && mounted) {
        setState(() {
          _image = File(image.path);
          _statusAbsensi = "Menunggu Konfirmasi";
        });
      }
    } catch (e) {
      _showSnackBar('Gagal mengambil gambar: $e');
    }
  }

  Future<void> _submitAbsensi() async {
    if (_image == null) {
      _showSnackBar('Harap ambil foto selfie terlebih dahulu');
      return;
    }

    if (_currentPosition == null) {
      _showSnackBar('Sedang mendapatkan lokasi...');
      await _getCurrentLocation();
      if (_currentPosition == null) return;
    }

    // Validasi lokasi
    double distance = Geolocator.distanceBetween(
      _absenLatitude,
      _absenLongitude,
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    if (distance > _maxDistanceMeters) {
      _showSnackBar(
        'Anda berada di luar area absensi (jarak: ${distance.toStringAsFixed(2)} meter). Maksimal 10 meter.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusAbsensi = "Absensi Berhasil";
        });
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Gagal mengirim absensi: $e');
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Absensi Berhasil'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Waktu: ${_fullDateTimeFormat.format(_currentTime)}'),
                const SizedBox(height: 8),
                Text(
                  'Lokasi: ${_currentPosition!.latitude.toStringAsFixed(6)}, ${_currentPosition!.longitude.toStringAsFixed(6)}',
                ),
                const SizedBox(height: 16),
                if (_image != null)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Image.file(_image!),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Izin Diperlukan'),
            content: const Text(
              'Aplikasi membutuhkan izin kamera dan lokasi. Aktifkan di pengaturan.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Buka Pengaturan'),
              ),
            ],
          ),
    );
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Layanan Lokasi Dimatikan'),
            content: const Text('Aktifkan layanan lokasi untuk melanjutkan.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Geolocator.openLocationSettings();
                },
                child: const Text('Aktifkan'),
              ),
            ],
          ),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Online'), centerTitle: true),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTimeCard(),
                    const SizedBox(height: 20),
                    _buildLocationCard(),
                    const SizedBox(height: 20),
                    _buildPhotoCard(),
                    const SizedBox(height: 20),
                    _buildStatusCard(),
                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                  ],
                ),
              ),
    );
  }

  Widget _buildTimeCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.access_time, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              _dateFormat.format(_currentTime),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              _timeFormat.format(_currentTime),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on, size: 24, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Lokasi Saat Ini',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _currentPosition != null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latitude : ${_currentPosition!.latitude.toStringAsFixed(6)}',
                    ),
                    Text(
                      'Longitude: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                    ),
                    Text(
                      'Akurasi  : ± ${_currentPosition!.accuracy.toStringAsFixed(2)} meter',
                      style: TextStyle(
                        color:
                            _currentPosition!.accuracy <= 20
                                ? Colors.green
                                : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: _getCurrentLocation,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text("Perbarui Lokasi"),
                      ),
                    ),
                  ],
                )
                : const Text(
                  'Lokasi tidak tersedia',
                  style: TextStyle(color: Colors.red),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.camera_alt, size: 24, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Foto Selfie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _image == null ? Colors.grey : Colors.blue,
                  width: 2,
                ),
              ),
              child:
                  _image == null
                      ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text('Belum ada foto'),
                          ],
                        ),
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(_image!, fit: BoxFit.cover),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Selfie Anda',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Ambil Foto'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Status Absensi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(), width: 1),
              ),
              child: Text(
                _statusAbsensi,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitAbsensi,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          _isLoading
              ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
              : const Text(
                'KIRIM ABSENSI',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }

  Color _getStatusColor() {
    switch (_statusAbsensi) {
      case "Absensi Berhasil":
        return Colors.green;
      case "Menunggu Konfirmasi":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
