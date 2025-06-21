import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];

  List<Flashcard> get flashcards => _flashcards;

  FlashcardProvider() {
    loadFlashcards();
  }

  void addFlashcard(Flashcard flashcard) {
    _flashcards.add(flashcard);
    saveFlashcards();
    notifyListeners();
  }

  void deleteFlashcard(int index) {
    _flashcards.removeAt(index);
    saveFlashcards();
    notifyListeners();
  }

  void saveFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> flashcardList =
    _flashcards.map((card) => json.encode(card.toMap())).toList();
    await prefs.setStringList('flashcards', flashcardList);
  }

  void loadFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? flashcardList = prefs.getStringList('flashcards');
    if (flashcardList != null) {
      _flashcards = flashcardList
          .map((card) => Flashcard.fromMap(json.decode(card)))
          .toList();
      notifyListeners();
    }
  }
}
