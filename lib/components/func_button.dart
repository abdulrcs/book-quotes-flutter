import 'package:flutter/material.dart';

class FuncButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  FuncButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Text(text),
    );
  }
}
