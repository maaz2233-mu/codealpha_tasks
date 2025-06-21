import 'package:flutter/material.dart';
import 'package:language_learning_app/data/dummy_lessons.dart';
import 'package:language_learning_app/screens/lesson_screen.dart';
import 'package:language_learning_app/widgets/lesson_tile.dart';

import '../widgets/lesson_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Languages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {
              Navigator.pushNamed(context, '/achievements');
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: dummyLessons.length,
        itemBuilder: (context, index) {
          final lesson = dummyLessons[index];
          return LessonTile(
            lesson: lesson,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonScreen(lesson: lesson),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
