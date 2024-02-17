import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const ufo_green = Color(0xFF2ecc71);
const padding8 = EdgeInsets.all(8.0);
const radius = BorderRadius.vertical(top: Radius.circular(36));

const kButtonTextStyle = TextStyle(
    color: Colors.black, letterSpacing: 0.5, fontWeight: FontWeight.w500);
const kTextStyle = 

TextStyle(color: Colors.black, fontWeight: FontWeight.w600);
const kHeaderStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 36);
const kWelcomeTextStyle =
    TextStyle(color: Colors.black87, overflow: TextOverflow.clip, fontSize: 16,shadows: [Shadow(
      color: Colors.black26,blurRadius: 1,offset: Offset(0, 1)
    )]);

const kButtonStyle = ButtonStyle(
    alignment: Alignment.center,
    elevation: MaterialStatePropertyAll(20),
    textStyle: MaterialStatePropertyAll(
        TextStyle(color: Colors.black, fontWeight: FontWeight.w800,letterSpacing: 2)),
    backgroundColor: MaterialStatePropertyAll(ufo_green));

const kPadding24 = EdgeInsets.all(24.0);
const kBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36), topRight: Radius.circular(36)));

// ignore: camel_case_types
class appTexts {
  static const welcome2 =
      "Bu yolculukta yalnız olmadığını bil ve bağımlılıklarından kurtulmak için ilk adımını at.";
}
