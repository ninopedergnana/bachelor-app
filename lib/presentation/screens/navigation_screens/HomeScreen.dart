import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-certificate');
                },
                elevation: 0.0,
                fillColor: Colors.blueGrey,
                child: const Icon(
                  Icons.add, color: Colors.white,
                  size: 35.0,
                ),
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
              ),
          ]
        ),
      )
    );
  }
}
