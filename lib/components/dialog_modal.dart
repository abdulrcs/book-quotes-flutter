import 'package:flutter/material.dart';
import 'package:flutter_pemmob_crud/components/func_button.dart';

class DialogModal extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogModal({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.yellow[300],
        content: Container(
            height: 120,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a new Task",
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
