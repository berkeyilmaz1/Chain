import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class newDailyClicker extends StatefulWidget {
  const newDailyClicker({super.key});

  @override
  _newDailyClickerState createState() => _newDailyClickerState();
}

class _newDailyClickerState extends State<newDailyClicker> {
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
  Future alreadyClicked(){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bugün zaten tıkladınız.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Butona basıldıkça artan değer:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonEnabled ? _incrementCounter : alreadyClicked,
        tooltip: 'Artır',
        child: Icon(Icons.add),
      ),
    );
  }
}