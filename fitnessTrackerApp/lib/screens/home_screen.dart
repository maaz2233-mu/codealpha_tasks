import 'package:flutter/material.dart';
import 'add_workout_screen.dart';
import 'goals_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildMenuTile(
              icon: Icons.fitness_center,
              title: 'Add Workout',
              context: context,
              page: const AddWorkoutScreen(),
            ),
            const SizedBox(height: 20),
            _buildMenuTile(
              icon: Icons.flag,
              title: 'Set Goals',
              context: context,
              page: const GoalsScreen(),
            ),
            const SizedBox(height: 20),
            _buildMenuTile(
              icon: Icons.bar_chart,
              title: 'Progress',
              context: context,
              page: const ProgressScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required BuildContext context,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.green.shade800),
            const SizedBox(width: 20),
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
