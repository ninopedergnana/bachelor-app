import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const LargeButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: color,
        elevation: 0,
      ),
    );
  }
}
