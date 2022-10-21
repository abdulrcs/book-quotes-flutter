import 'package:flutter/material.dart';
import 'package:flutter_pemmob_crud/components/func_button.dart';

class DialogModal extends StatelessWidget {
  final controllers;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogModal({
    super.key,
    required this.controllers,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 500,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: controllers[0],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Quote Text",
                    ),
                  ),
                  TextField(
                    controller: controllers[1],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Book Title",
                    ),
                  ),
                  TextField(
                    controller: controllers[2],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Author",
                    ),
                  ),
                  TextField(
                    controller: controllers[3],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Chapter",
                    ),
                  ),
                  TextField(
                    controller: controllers[4],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Book Cover Link",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FuncButton(text: 'Save', onPressed: onSave),
                      SizedBox(width: 8),
                      FuncButton(text: 'Cancel', onPressed: onCancel),
                    ],
                  ),
                ])));
  }
}
