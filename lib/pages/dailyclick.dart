import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyClicker extends StatefulWidget {
  @override
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
      _prefs.setInt('lastClickTimestamp', DateTime.now().millisecondsSinceEpoch);
      // Perform any action you want after a successful click here
    } else {
      // Optionally, you can show a message indicating the user already clicked today
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Already Clicked Today'),
          content: Text('You have already clicked today.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Clicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click Count: $_clickCount',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleButtonClick,
              child: Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}