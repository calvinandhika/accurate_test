import 'package:flutter/material.dart';

Future<void> showErrorDialog({
  required title,
  required body,
  required context,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
