import 'package:flutter/material.dart';
import 'package:language_learning_app/models/lesson_model.dart';
import 'package:language_learning_app/utils/shared_prefs.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool showResult = false;

  void checkAnswer(String selected) {
    final correct = widget.lesson.quiz[currentQuestion]['answer'];
    if (selected == correct) score++;

    if (currentQuestion < widget.lesson.quiz.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      SharedPrefs.saveProgress(widget.lesson.id);
      setState(() {
        showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionData = widget.lesson.quiz[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showResult
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              const SizedBox(height: 20),
              Text('You scored $score/${widget.lesson.quiz.length}',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              )
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${currentQuestion + 1}: ${questionData['question']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ...(questionData['options'] as List<String>).map(
                  (option) => Card(
                child: ListTile(
                  title: Text(option),
                  onTap: () => checkAnswer(option),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
