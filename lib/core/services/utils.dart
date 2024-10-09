import 'package:flutter/material.dart';
class Util {
  static customShowDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erreur "),
          content: Text(message),
          actions: [
           TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
          ],
        );
      });
}
}