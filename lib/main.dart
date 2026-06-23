import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'seed/seed_programs.dart';

import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'delete_duplicates.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //await seedPrograms();
  await deleteFrontendPrograms();

  runApp(const ExcelerateApp());
}

class ExcelerateApp extends StatelessWidget {
  const ExcelerateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Pathfinder',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: const Color(0xFFE0194A),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        fontFamily: 'Roboto',
      ),

      // Start app here
      home: const SplashScreen(),
    );
  }
}
