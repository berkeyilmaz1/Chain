import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewDailyClicker extends StatefulWidget {
  const NewDailyClicker({super.key});

  @override
  _NewDailyClickerState createState() => _NewDailyClickerState();
}

class _NewDailyClickerState extends State<NewDailyClicker> {
  List<int> _counters = [];
  List<bool> _buttonEnabled = [];

  @override
  void initState() {
    super.initState();
    checkLastButtonClickDate();
  }

  void checkLastButtonClickDate() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (int i = 0; i < _counters.length; i++) {
      final documentSnapshot = await _firestore
          .collection('last_click')
          .doc('button_$i')
          .get();
      if (documentSnapshot.exists) {
        final lastClickDate = documentSnapshot.get('last_click_date');
        if (lastClickDate == today) {
          setState(() {
            _buttonEnabled[i] = false;
          });
        }
      }
    }
  }

  void _incrementCounter(int index) async {
    setState(() {
      _counters[index] += 10;
      _buttonEnabled[index] = false;
    });

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      await _firestore
          .collection('deger')
          .doc('butonDegeri_$index')
          .set({'deger': _counters[index]});
      await _firestore
          .collection('last_click')
          .doc('button_$index')
          .set({'last_click_date': today});
      print('Değer Firestore\'a yazıldı: ${_counters[index]}');
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
            for (int i = 0; i < _counters.length; i++)
              Column(
                children: [
                  Text(
                    'Buton ${i + 1} için değer:',
                  ),
                  Text(
                    '${_counters[i]}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (int i = 0; i < _counters.length; i++)
            FloatingActionButton(
              onPressed: _buttonEnabled[i]
                  ? () => _incrementCounter(i)
                  : alreadyClicked, 
              tooltip: 'Artır',
              child: Icon(Icons.add),
            ),
        ],
      ),
    );
  }
}


