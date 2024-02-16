import 'package:flutter/material.dart';
class MySizedBox extends StatelessWidget {
   const MySizedBox({
    super.key,
    required this.height,
    required this.widht, 
  });
  // ignore: prefer_typing_uninitialized_variables
  final double height;
  final double widht;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: widht,
    );
  }
}
