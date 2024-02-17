import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';


class MyTextBox extends StatelessWidget {
  final String boxName;
  
  final String text;

  const MyTextBox({super.key, required this.boxName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ufo_green,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      padding: EdgeInsets.only(left: 15,bottom: 15),
      margin: EdgeInsets.only(left:20,right: 20,top:20),
      child: Column(
        children: [
          Text(boxName),
          Text(text)
        ],
      ),
    );
  }
}