import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;

  const TextInput({Key? key, required this.label, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: false,
          hintText: label,
          labelText: label,
        ),
    );
  }
}