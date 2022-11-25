import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool isBigger;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomFormField({
    Key? key,
    required this.title,
    required this.controller,
    required this.textInputType,
    this.isBigger = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        minLines: isBigger ? 4 : null,
        maxLines: isBigger ? 6 : 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),
          labelText: title,
          fillColor: Colors.grey.shade300,
          filled: true,
          hintText: 'Input Your Name',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.lightBlue.shade600,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
