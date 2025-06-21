import 'package:flutter/material.dart';
import 'package:language_learning_app/models/lesson_model.dart';
import 'package:language_learning_app/screens/quiz_screen.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lesson Content:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...lesson.content.map((line) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('• $line', style: const TextStyle(fontSize: 16)),
            )),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.quiz),
                label: const Text('Take Quiz'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(lesson: lesson),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
