import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schallange/components/myPostButton.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/components/myTextField.dart';
import 'package:schallange/components/ratingBar.dart';
import 'package:schallange/database/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomMessagePage extends StatefulWidget {
  const RandomMessagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomMessagePageState createState() => _RandomMessagePageState();
}

class _RandomMessagePageState extends State<RandomMessagePage> {
  final TextEditingController _newPromiseController = TextEditingController();
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
  //add a promise
  List<String> items = [];
  void addItem(String newItem) {
    setState(() {
      items.add(newItem);
    });
  }

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

  void Function()? onPressed;
  final FirestoreDatabase database = FirestoreDatabase();

  void postMessage() {
    if (_newPromiseController.text.isNotEmpty) {
      String message = _newPromiseController.text;
      database.addPost(message);
    }
    _newPromiseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Günlük Motivasyon'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          style: const TextStyle(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: width,
                    child: const Center(
                        child: Text('Bugün Kendini Nasıl Hissediyorsun ?',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)))),
                const MySizedBox(height: 20, widht: 0),
                const MyRatingBar(),
                const MySizedBox(height: 10, widht: 0)
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextField(
                        name: "Kendime Verdiğim Söz",
                        obscureText: false,
                        controllerName: _newPromiseController),
                  ),
                  myPostButton(
                    onTap: postMessage,
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final posts = snapshot.data!.docs;
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Söz Verilmedi'),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        String message = post['postMessage'];
                        String userEmail = post['Useremail'];
                        String timestamp = post['TimeStamp'];
                        return ListTile(
                          title: Text(message),
                          subtitle: Text(userEmail),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
