import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';

class MyTextBox extends StatelessWidget {
  final String boxName;

  final String text;

  const MyTextBox({super.key, required this.boxName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
            color: ufo_green,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: ListTile(
          title: Text(
            boxName,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline),
          ),
          subtitle: Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
