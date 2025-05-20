import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ProjectManagementApp());
}

class ProjectManagementApp extends StatelessWidget {
  const ProjectManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KonstruksiPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
