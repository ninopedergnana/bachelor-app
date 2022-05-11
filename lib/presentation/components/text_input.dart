import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;

  const TextInput({Key? key, required this.label, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: textEditingController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          filled: false,
          hintText: label,
          labelText: label,
        ),
    );
  }
}