import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 10;
  bool _buttonEnabled = true;

  @override
  void initState() {
    super.initState();
    checkLastButtonClickDate();
  }

  void checkLastButtonClickDate() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final documentSnapshot =
        await _firestore.collection('last_click').doc('last_click_info').get();
    if (documentSnapshot.exists) {
      final lastClickDate = documentSnapshot.get('last_click_date');
      if (lastClickDate == today) {
        setState(() {
          _buttonEnabled = false;
        });
      }
    }
  }

  void _incrementCounter() async {
    setState(() {
      _counter += 10;
      _buttonEnabled = false;
    });

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      await _firestore
          .collection('deger')
          .doc('butonDegeri')
          .set({'deger': _counter});
      await _firestore.collection('last_click').doc('last_click_info').set({
        'last_click_date': today,
      });
      print('Değer Firestore\'a yazıldı: $_counter');
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Butona basıldıkça artan değer:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonEnabled ? _incrementCounter : null,
        tooltip: 'Artır',
        child: Icon(Icons.add),
      ),
    );
  }
}
