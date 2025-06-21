import '../models/lesson_model.dart';

final List<Lesson> dummyLessons = [
  Lesson(
    id: '1',
    title: 'Basic Greetings',
    content: ['Hello', 'Good morning', 'How are you?'],
    quiz: [
      {
        'question': 'How do you say "Hello"?',
        'options': ['Hola', 'Bonjour', 'Hello'],
        'answer': 'Hello',
      },
      {
        'question': 'What is "Good morning"?',
        'options': ['Good morning', 'Good night', 'Thank you'],
        'answer': 'Good morning',
      },
    ],
  ),
  Lesson(
    id: '2',
    title: 'Common Phrases',
    content: ['Thank you', 'Please', 'Excuse me'],
    quiz: [
      {
        'question': 'How do you say "Thank you"?',
        'options': ['Sorry', 'Thank you', 'Bye'],
        'answer': 'Thank you',
      },
    ],
  ),
];
