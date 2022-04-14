import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomDialog {

  Future<void> showQRDialog(BuildContext context, String key, String title) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Container (
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: QrImage(
                data: key,
                version: QrVersions.auto,
                gapless: true,
                errorStateBuilder: (cxt, err) {
                  print(err);
                  print(cxt);
                  return const Center(
                    child: Text(
                      "Uh oh! Something went wrong while scanning the code",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}