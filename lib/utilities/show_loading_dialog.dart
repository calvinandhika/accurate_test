import 'package:accurate_test/models/user_model.dart';
import 'package:flutter/material.dart';

Future<void> showLoadingDialog({
  required context,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
