import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';

// ignore: camel_case_types
class myAlertBox extends StatelessWidget {
  final double rating;

  final String message;

  const myAlertBox({super.key, required this.rating, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        style: kTextStyle.copyWith(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kapat'),
        ),
      ],
    );
  }
}
