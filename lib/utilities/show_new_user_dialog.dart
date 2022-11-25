import 'package:accurate_test/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showNewUserDialog({
  required title,
  required UserModelData? body,
  required context,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text('''Name: ${body?.name}
Email: ${body?.email}
Phone: ${body?.phoneNumber}
Address: ${body?.address}
City: ${body?.city}
'''),
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
