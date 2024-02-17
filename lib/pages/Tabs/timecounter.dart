import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeCounterPage extends StatefulWidget {
  const TimeCounterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeCounterPageState createState() => _TimeCounterPageState();
}

class _TimeCounterPageState extends State<TimeCounterPage>
    with WidgetsBindingObserver {
  late SharedPreferences _prefs;
  DateTime selectedDate = DateTime.now();
  Timer? timer;
  Duration timeElapsed = const Duration();
  final double borderWidth = 8.0;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String? storedDateTime = _prefs.getString('selected_date');
    if (storedDateTime != null) {
      setState(() {
        selectedDate = DateTime.parse(storedDateTime);
      });
    }
    startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveData();
    }
  }

  void _saveData() {
    _prefs.setString('selected_date', selectedDate.toIso8601String());
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed = DateTime.now().difference(selectedDate);
      });
    });
  }

  void resetTimer() {
    setState(() {
      selectedDate = DateTime.now();
      timeElapsed = const Duration();
    });
    _prefs.remove('selected_date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(' Bağımlılığı'),
      ),
      body: Column(
        children: <Widget>[
          const MySizedBox(height: 40, widht: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: TimerPainter(
                    timeElapsed: timeElapsed,
                    backgroundColor: Colors.grey[300]!,
                    color: ufo_green,
                    borderWidth: borderWidth,
                  ),
                  child: Center(
                    child: Text(
                      '${timeElapsed.inHours}:${(timeElapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(timeElapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    selectedDate = value;
                    _saveData(); // Save when date changes
                  });
                }
              });
            },
            child: const Text(
              'Başlama Tarihini Seçiniz',
              style: kButtonTextStyle,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: resetTimer,
            child: const Text(
              'Sayacı Sıfırla',
              style: kButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Duration timeElapsed;
  final Color backgroundColor;
  final Color color;
  final double borderWidth;

  TimerPainter({
    required this.timeElapsed,
    required this.backgroundColor,
    required this.color,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double percentage = timeElapsed.inSeconds / Duration.secondsPerHour;
    final double arcAngle = 2 * pi * percentage;

    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Paint foregroundPaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    canvas.drawCircle(center, radius, backgroundPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return oldDelegate.timeElapsed != timeElapsed;
  }
}
