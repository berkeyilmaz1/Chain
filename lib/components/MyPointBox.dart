import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';

class MyPointBox extends StatelessWidget {
  final double puan;
  final String boxTitle;

  const MyPointBox({super.key, required this.puan, required this.boxTitle});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: width * 0.60,
              decoration: const BoxDecoration(
                  color: ufo_green,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Text(
                boxTitle,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
            ),
            Container(
              height: 80,
              width: width * 0.25,
              decoration: const BoxDecoration(
                  color: ufo_green,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Text(
                puan.toString() ,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
