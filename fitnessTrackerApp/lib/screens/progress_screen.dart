import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Map<String, String> _workouts = {};

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final all = prefs.getKeys();
    Map<String, String> workouts = {};
    for (var key in all) {
      if (key.contains('T')) {
        // ISO datetime format check
        workouts[key] = prefs.getString(key) ?? '';
      }
    }

    // Sort by date (descending)
    final sortedKeys = workouts.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    setState(() {
      _workouts = {for (var k in sortedKeys) k: workouts[k]!};
    });
  }

  Future<void> _deleteWorkout(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _loadWorkouts(); // refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        backgroundColor: Colors.green,
      ),
      body: _workouts.isEmpty
          ? const Center(child: Text('No workouts recorded yet.'))
          : ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          String dateKey = _workouts.keys.elementAt(index);
          String workout = _workouts[dateKey]!;
          DateTime date = DateTime.parse(dateKey);
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(workout),
              subtitle: Text(
                  '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteWorkout(dateKey),
              ),
            ),
          );
        },
      ),
    );
  }
}
