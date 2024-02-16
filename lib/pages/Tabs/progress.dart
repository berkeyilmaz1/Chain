import 'package:flutter/material.dart';
import 'package:schallange/pages/Tabs/timecounter.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("İlerleme"),
        
      ),
      body:const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeCounterPage(),
        ],
      )
    );
  }
}
