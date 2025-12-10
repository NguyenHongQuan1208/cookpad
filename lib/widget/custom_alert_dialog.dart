import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Map<String, VoidCallback> buttonContent;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonContent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: buttonContent.entries.map((entry) {
        return TextButton(onPressed: entry.value, child: Text(entry.key));
      }).toList(),
    );
  }
}
