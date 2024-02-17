// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomMessagePage extends StatefulWidget {
  const RandomMessagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomMessagePageState createState() => _RandomMessagePageState();
}

class _RandomMessagePageState extends State<RandomMessagePage> {
  List<String> messages = [
    "İmkansızı başarabilirsin!",
    "Yarın daha iyi olacak.",
    "Her adım ileriye doğru.",
    "Hayallerine doğru ilerle yavaşça.",
    "Hiçbir şey seni durduramaz.",
    "Güçlü kal, mücadele et!",
    "Pes etme, zafer senin olacak.",
    "Hayallerin gerçek olacak, inan!",
    "Her gün bir adım daha ileri.",
    "Sınırlarını zorla, başarı seninle.",
  ];

  String selectedMessage = '';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    prefs = await SharedPreferences.getInstance();
    _updateMessage();
  }

  void _updateMessage() {
    String? storedMessage = prefs.getString('message');
    String? storedDate = prefs.getString('date');
    String currentDate = DateTime.now().toString().split(' ')[0];

    if (storedDate != currentDate) {
      setState(() {
        selectedMessage = _getRandomMessage();
      });
      prefs.setString('message', selectedMessage);
      prefs.setString('date', currentDate);
    } else {
      setState(() {
        selectedMessage = storedMessage ?? '';
      });
    }
  }

  String _getRandomMessage() {
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Günlük Motivasyon'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(
                            "images/rockss.jpg",
                          ),
                          fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedMessage,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
