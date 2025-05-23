import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:simanpro_v02/screens/home_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ), // ganti halaman tujuan
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 178, 252, 255)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/pdkb.png', width: 200, height: 200)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scaleXY(begin: 0.1, end: 1.5, duration: 1200.ms),
              const SizedBox(height: 20),
              Text(
                    'KonstruksiPro',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.blue,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 1, end: 0, duration: 600.ms)
                  .fadeIn(duration: 500.ms, delay: 200.ms),
              const SizedBox(height: 10),
              Text(
                'Powered by PT. PRISAN ARTHA LESTARI',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ).animate().fadeIn(duration: 1000.ms, delay: 600.ms),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.blueAccent,
                  )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scaleXY(end: 1.2, duration: 500.ms)
                  .then()
                  .scaleXY(end: 1.0, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
