import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomMessagePage extends StatefulWidget {
  const RandomMessagePage({super.key});

  @override
  _RandomMessagePageState createState() => _RandomMessagePageState();
}

class _RandomMessagePageState extends State<RandomMessagePage> {
  List<String> messages = [
    "Güçlü bir başlangıç, başarılı bir sonuç getirir.",
    "Hayallerinize giden yolda engeller sadece duraklamanızı bekleyen araçlardır.",
    "Küçük adımlar, büyük başarılar getirir.",
    "Korkularınızı yenin, sınırlarınızı zorlayın, hayallerinize doğru ilerleyin.",
    "Başarınızı belirleyen, düşüncelerinizdir. Pozitif düşünün, başarıya giden yol açılacaktır.",
    "Pes etmek, zaferinizi başkasına teslim etmektir.",
    "Her gün küçük bir ilerleme, büyük bir başarı getirir.",
    "Zorluklar, güçlü insanların doğduğu yerdir."
    "Düşmekten korkma, yeniden kalkmayı öğren.",
    "Yarının başarısını bugünün kararları belirler.",
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
double height = MediaQuery.of(context).size.height;

        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Günlük Motivasyon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                
                width:width ,
                height: height/2,
                child: Center(
                  child: Text(
                    selectedMessage,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
