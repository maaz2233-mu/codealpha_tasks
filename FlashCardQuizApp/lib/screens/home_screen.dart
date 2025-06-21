import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/flashcard_provider.dart';
import '../screens/add_flashcard_screen.dart';
import '../screens/quiz_screen.dart';
import '../theme/theme_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flashcards = context.watch<FlashcardProvider>().flashcards;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flashcards'),
        actions: const [ThemeToggle()],
      ),
      body: flashcards.isEmpty
          ? const Center(child: Text('No flashcards. Add some!'))
          : ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          final card = flashcards[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(card.question),
              subtitle: Text("Answer: ${card.answer}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<FlashcardProvider>().deleteFlashcard(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'quiz',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              );
            },
            child: const Icon(Icons.quiz),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFlashcardScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
