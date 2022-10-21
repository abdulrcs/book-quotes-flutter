import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookCard extends StatelessWidget {
  final String quoteText;
  final String author;
  final String bookTitle;
  final String chapterName;
  final String imageUrl;
  Function(BuildContext)? onEdit;
  Function(BuildContext)? onDelete;

  BookCard({
    super.key,
    required this.quoteText,
    required this.author,
    required this.bookTitle,
    required this.chapterName,
    required this.imageUrl,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SizedBox(width: 8),
            SlidableAction(
              onPressed: onEdit,
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(width: 8),
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
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
      ),
    );
  }
}
