import 'package:flutter/material.dart';
import 'package:language_learning_app/data/dummy_lessons.dart';
import 'package:language_learning_app/utils/shared_prefs.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedLessons = dummyLessons
        .where((lesson) => SharedPrefs.isLessonCompleted(lesson.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completedLessons.isEmpty
            ? const Center(
          child: Text(
            'No achievements yet. Complete lessons to unlock!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          itemCount: completedLessons.length,
          itemBuilder: (context, index) {
            final lesson = completedLessons[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: Text('Completed: ${lesson.title}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
