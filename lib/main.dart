import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'offline_form_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('offlineData');
  runApp(const ProjectManagementApp());
}

class ProjectManagementApp extends StatelessWidget {
  const ProjectManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KonstruksiPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
