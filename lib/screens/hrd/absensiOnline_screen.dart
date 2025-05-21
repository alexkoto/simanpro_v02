import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _requestPermissions() async {
  await [Permission.camera, Permission.location].request();
}

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

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _checkLocationPermission();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  Future<void> _checkLocationPermission() async {
    setState(() => _isLoading = true);
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      _showSnackBar('GPS tidak aktif. Mohon aktifkan lokasi.');
      setState(() => _isLoading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('Izin lokasi ditolak.');
        setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showDialog(
        'Izin Lokasi Diperlukan',
        'Anda telah menolak izin lokasi secara permanen. Aktifkan izin di pengaturan perangkat.',
      );
      setState(() => _isLoading = false);
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
    } catch (e) {
      _showSnackBar('Gagal mendapatkan lokasi: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _image = File(image.path);
          _statusAbsensi = "Menunggu Konfirmasi";
        });
      }
    } catch (e) {
      _showSnackBar('Gagal mengambil gambar: $e');
    }
  }

  void _submitAbsensi() {
    if (_image == null) {
      _showSnackBar('Harap ambil foto selfie terlebih dahulu');
      return;
    }

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _statusAbsensi = "Absensi Berhasil";
      });
      _showDialog(
        'Absensi Berhasil',
        'Waktu: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(_currentTime)}\nLokasi: ${_currentPosition != null ? '${_currentPosition!.latitude}, ${_currentPosition!.longitude}' : 'Tidak diketahui'}',
      );
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Online'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.access_time, size: 40),
                    const SizedBox(height: 8),
                    Text(DateFormat('EEEE, dd MMMM yyyy').format(_currentTime)),
                    Text(
                      DateFormat('HH:mm:ss').format(_currentTime),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _currentPosition != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lokasi Saat Ini',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Latitude: ${_currentPosition!.latitude}'),
                              Text('Longitude: ${_currentPosition!.longitude}'),
                              const SizedBox(height: 10),
                              TextButton.icon(
                                onPressed: _getCurrentLocation,
                                icon: const Icon(Icons.my_location),
                                label: const Text("Perbarui Lokasi"),
                              )
                            ],
                          )
                        : const Text('Lokasi tidak tersedia'),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Foto Selfie',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _image == null
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(child: Text('Belum ada foto')),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _image!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  color: Colors.black54,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: const Text(
                                    'Selfie Anda',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _takePicture,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Ambil Foto'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Status Absensi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _statusAbsensi,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _statusAbsensi == "Absensi Berhasil" ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitAbsensi,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'KIRIM ABSENSI',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
