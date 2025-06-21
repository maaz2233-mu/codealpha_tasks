import 'package:flutter/material.dart';
import 'package:language_learning_app/screens/achievement_screen.dart';
import 'package:language_learning_app/screens/splash_screen.dart';
import 'package:language_learning_app/screens/home_screen.dart';
import 'package:language_learning_app/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init(); // Initialize Shared Preferences
  runApp(const LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/achievements': (context) => const AchievementScreen(),

      },
    );
  }
}
