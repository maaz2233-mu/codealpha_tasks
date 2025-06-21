import 'package:flutter/material.dart';
import 'package:language_learning_app/models/lesson_model.dart';
import 'package:language_learning_app/utils/shared_prefs.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;

  const LessonTile({super.key, required this.lesson, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final completed = SharedPrefs.isLessonCompleted(lesson.id);

    return Card(
      child: ListTile(
        title: Text(lesson.title),
        leading: Icon(completed ? Icons.check_circle : Icons.circle_outlined),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
