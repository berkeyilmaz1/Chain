import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';


class Mybutton extends StatelessWidget {
  const Mybutton(
      {super.key, this.onPressed, required this.buttonName, this.buttonWidht});
  final Function()? onPressed;
  final String buttonName;
  final double? buttonWidht;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: kButtonStyle,
        child: Text(
          buttonName,
          style: kButtonTextStyle,
        ));
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key, this.onPressed, required this.name,
  });
final Function()? onPressed;
final String name;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child:  Text(
          name,
          style: kTextStyle,
        ));
  }
}
