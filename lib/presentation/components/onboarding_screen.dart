import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final String imageURLString;
  final String title;
  final String content;
  const OnboardingScreen({Key? key, required this.imageURLString, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage(imageURLString),
              height: 250.0,
              width: 250.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              height: 1.5,),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
