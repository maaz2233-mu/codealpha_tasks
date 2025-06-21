class Lesson {
  final String id;
  final String title;
  final List<String> content;
  final List<Map<String, dynamic>> quiz;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.quiz,
  });
}
