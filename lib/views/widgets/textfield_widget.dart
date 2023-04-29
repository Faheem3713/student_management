import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.text,
      this.type = TextInputType.text});
  final TextEditingController controller;
  final String text;
  final TextInputType type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: type,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field cannot be empty';
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(text),
        ),
      ),
    );
  }
}
