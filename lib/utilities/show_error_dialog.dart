import 'package:accurate_test/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Get.back();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
