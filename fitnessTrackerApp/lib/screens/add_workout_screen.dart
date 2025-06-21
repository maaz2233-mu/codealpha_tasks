import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Running';
  final TextEditingController _durationController = TextEditingController();

  List<String> workoutTypes = [
    'Running',
    'Push-ups',
    'Sit-ups',
    'Cycling',
    'Jump Rope'
  ];

  Future<void> _saveWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final key = DateTime.now().toIso8601String();
    final workout = '$_selectedType - ${_durationController.text}';
    await prefs.setString(key, workout);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Workout saved!')),
    );
    _durationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workout'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: workoutTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Exercise Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duration or Reps',
                  hintText: 'e.g., 30 minutes or 20 reps',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter value' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveWorkout();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Workout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
