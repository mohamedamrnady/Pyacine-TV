import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String content;
  final List<TextButton> buttons;
  const DialogBox({
    super.key,
    required this.title,
    required this.content,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: buttons,
    );
  }
}
