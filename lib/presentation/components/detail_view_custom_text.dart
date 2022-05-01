import 'package:flutter/material.dart';

class DetailViewCustomText extends StatelessWidget{
  final String? title;
  final String? content;

  const DetailViewCustomText({Key? key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(content!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
        const Divider(thickness: 0.5, color: Colors.grey)
      ],
    );
  }
}