import 'package:hive_flutter/hive_flutter.dart';

class QuotesDatabase {
  List quotes = [];

  final _localBox = Hive.box('localBox');

  void createInitialData() {
    quotes = [
      [
        "The only way to do great work is to love what you do.",
        "Steve Jobs",
        "Steve Jobs",
        "Chapter 1",
        "https://upload.wikimedia.org/wikipedia/id/thumb/e/e4/Steve_Jobs_by_Walter_Isaacson.jpg/220px-Steve_Jobs_by_Walter_Isaacson.jpg"
      ],
      [
        "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it.",
        "Steve Jobs",
        "Steve Jobs",
        "Chapter 1",
        "https://upload.wikimedia.org/wikipedia/id/thumb/e/e4/Steve_Jobs_by_Walter_Isaacson.jpg/220px-Steve_Jobs_by_Walter_Isaacson.jpg"
      ]
    ];
  }

  void loadData() {
    quotes = _localBox.get('quotes');
  }

  void updateDatabase() {
    _localBox.put('quotes', quotes);
  }
}
