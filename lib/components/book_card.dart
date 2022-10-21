import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String quoteText;
  final String author;
  final String bookTitle;
  final String chapterName;
  final String imageUrl;

  BookCard({
    super.key,
    required this.quoteText,
    required this.author,
    required this.bookTitle,
    required this.chapterName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
        child: ListTile(
          leading: Image.network(imageUrl),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(quoteText),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$author, $bookTitle, $chapterName'),
          ),
        ),
      ),
    );
  }
}
