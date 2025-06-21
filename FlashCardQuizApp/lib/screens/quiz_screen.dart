import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  List<Flashcard> shuffledCards = [];
  List<String> currentShuffledOptions = [];

  @override
  void initState() {
    super.initState();
    shuffledCards = List.from(context.read<FlashcardProvider>().flashcards)..shuffle();
    if (shuffledCards.isNotEmpty) {
      currentShuffledOptions = List.from(shuffledCards[currentIndex].options)..shuffle();
    }
  }

  void nextQuestion() {
    setState(() {
      currentIndex++;
      if (currentIndex < shuffledCards.length) {
        currentShuffledOptions =
        List.from(shuffledCards[currentIndex].options)..shuffle();
      }
    });
  }

  void checkAnswer(String selectedOption) {
    final currentCard = shuffledCards[currentIndex];
    final isCorrect = selectedOption == currentCard.answer;

    if (isCorrect) score++;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Correct ✅' : 'Wrong ❌'),
        content: Text('Answer: ${currentCard.answer}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              nextQuestion();
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= shuffledCards.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Finished')),
        body: Center(
          child: Text(
            'Your score: $score / ${shuffledCards.length}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      );
    }

    final currentCard = shuffledCards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Time')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${currentIndex + 1}: ${currentCard.question}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ...currentShuffledOptions.map(
                  (option) => ListTile(
                title: Text(option),
                tileColor: Colors.blue.shade50,
                onTap: () => checkAnswer(option),
              ),
            ),
            const Spacer(),
            Text("Score: $score", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
