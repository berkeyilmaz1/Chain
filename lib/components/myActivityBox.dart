import 'package:flutter/material.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

double point = 0;

class MyActivityBox extends StatefulWidget {
  final String title;
  final String text;

  const MyActivityBox({super.key, required this.title, required this.text});

  @override
  State<MyActivityBox> createState() => _MyActivityBoxState();
}

class _MyActivityBoxState extends State<MyActivityBox> {
  bool buttonEnabled = true;

  @override
  void initState() {
    super.initState();
    // checkButtonEnabled();
  }

  Future<void> checkButtonEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool buttonClicked = prefs.getBool('buttonClicked') ?? false;
    setState(() {
      buttonEnabled = !buttonClicked;
    });
  }

  Future<void> onButtonPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('20 puan kazandınız !',style: kTextStyle,),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam!'),
          ),
        ],
      ),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('buttonClicked', true);

    setState(() {
      buttonEnabled = false;
    });
  }

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
                    child: Text(widget.title,
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
                    child: Text(widget.text,
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
              buttonEnabled
                  ? InkWell(
                      onTap: () {
                        onButtonPressed();
                        point += 20;
                      },
                      child: Container(
                        width: 90,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Center(
                            child: Text("+ 20", style: kTextStyle)),
                      ),
                    )
                  : Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(24)),
                      child:
                          const Center(child: Text("+ 20", style: kTextStyle)),
                    )
              //  const SizedBox(width: 90, height: 50, child: DailyClicker()),
            ],
          ),
        ),
      ),
    );
  }
}
