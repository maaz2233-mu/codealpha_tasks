class Flashcard {
  final String question;
  final String answer;
  final List<String> options;

  Flashcard({
    required this.question,
    required this.answer,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'options': options,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      question: map['question'],
      answer: map['answer'],
      options: List<String>.from(map['options']),
    );
  }
}
