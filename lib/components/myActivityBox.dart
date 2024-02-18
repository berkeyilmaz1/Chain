import 'package:flutter/material.dart';
import 'package:schallange/components/dailyclick.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';

class MyActivityBox extends StatelessWidget {
  final String title;
  final String text;

  const MyActivityBox({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: width,
        decoration: const BoxDecoration(
            color: ufo_green,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [BoxShadow(color: Colors.black45)]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: width - 150,
                    child: Text(title,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            color: Colors.black87,
                            overflow: TextOverflow.clip,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  offset: Offset(0, 1))
                            ])),
                  ),
                  const MySizedBox(height: 2, widht: 0),
                  SizedBox(
                    width: width - 150,
                    child: Text(text,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            color: Colors.black87,
                            overflow: TextOverflow.clip,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  offset: Offset(0, 1))
                            ])),
                  )
                ],
              ),
              const SizedBox(width: 90, height: 50, child: DailyClicker()),
            ],
          ),
        ),
      ),
    );
  }
}
