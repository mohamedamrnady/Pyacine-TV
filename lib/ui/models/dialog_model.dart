import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String content;
  final List<String> buttons;
  final List<void Function()?> actions;
  const DialogBox({
    super.key,
    required this.title,
    required this.content,
    required this.buttons,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ListView.builder(
          itemCount: buttons.length,
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: actions[index],
              child: Text(buttons[index]),
            );
          },
        )
      ],
    );
  }
}
