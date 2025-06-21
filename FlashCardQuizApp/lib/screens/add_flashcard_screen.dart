import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/flashcard.dart';
import '../providers/flashcard_provider.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({super.key});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final questionController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();

  int _selectedAnswerIndex = 0; // 0 = Option 1, 1 = Option 2, ...

  void saveFlashcard() {
    List<String> options = [
      option1Controller.text,
      option2Controller.text,
      option3Controller.text,
      option4Controller.text,
    ];

    final newCard = Flashcard(
      question: questionController.text,
      answer: options[_selectedAnswerIndex], // ✅ User selected correct answer
      options: options,
    );

    context.read<FlashcardProvider>().addFlashcard(newCard);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    questionController.dispose();
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();
    super.dispose();
  }

  Widget buildOptionInput(String label, TextEditingController controller, int index) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
        ),
        Radio<int>(
          value: index,
          groupValue: _selectedAnswerIndex,
          onChanged: (value) {
            setState(() {
              _selectedAnswerIndex = value!;
            });
          },
        ),
        const Text('Correct')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              const SizedBox(height: 10),
              buildOptionInput('Option 1', option1Controller, 0),
              buildOptionInput('Option 2', option2Controller, 1),
              buildOptionInput('Option 3', option3Controller, 2),
              buildOptionInput('Option 4', option4Controller, 3),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveFlashcard,
                child: const Text('Save Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
