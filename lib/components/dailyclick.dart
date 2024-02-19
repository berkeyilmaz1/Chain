import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyClicker extends StatefulWidget {
  const DailyClicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DailyClickerState createState() => _DailyClickerState();
}

class _DailyClickerState extends State<DailyClicker> {
  late SharedPreferences _prefs;
  int _clickCount = 0;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadClickCount();
  }

  void _loadClickCount() {
    setState(() {
      _clickCount = _prefs.getInt('clickCount') ?? 0;
    });
  }

  void _incrementClick() {
    setState(() {
      _clickCount++;
      _prefs.setInt('clickCount', _clickCount);
    });
  }

  bool _canClickToday() {
    // Check if the last click was made today
    DateTime lastClick = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt('lastClickTimestamp') ?? 0);
    DateTime today = DateTime.now();
    return today.difference(lastClick).inDays > 0;
  }

  void _handleButtonClick() {
    if (_canClickToday()) {
      _incrementClick();
      _prefs.setInt(
          'lastClickTimestamp', DateTime.now().millisecondsSinceEpoch);
      // Perform any action you want after a successful click here
    } else {
      // Optionally, you can show a message indicating the user already clicked today
      showDialog(
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
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    ElevatedButton(

      style: const ButtonStyle(elevation: MaterialStatePropertyAll(20),
      backgroundColor:  MaterialStatePropertyAll(Colors.white)),
      onPressed: _handleButtonClick,
      child: const Text('Tıkla',style: kButtonTextStyle,),
    );
  }
}
