import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';

class MyPointBox extends StatelessWidget {
  final String puan;
  final String boxTitle;

  const MyPointBox({super.key, required this.puan, required this.boxTitle});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double height = 70;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 8),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height,
              width: width * 0.60,
              decoration: const BoxDecoration(
                  color: ufo_green,
                  boxShadow: [
                    BoxShadow(blurRadius: 2,blurStyle: BlurStyle.outer)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Text(
                boxTitle,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
            ),
            Container(
              height: height,
              width: width * 0.25,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 2,blurStyle: BlurStyle.outer)
                  ],
                  color: ufo_green,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Text(
                puan,
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
