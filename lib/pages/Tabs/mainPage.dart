import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/pages/Tabs/motivation.dart';
import 'package:schallange/pages/Tabs/profile.dart';
import 'package:schallange/pages/Tabs/timecounter.dart';
import 'package:schallange/constants/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    String progessLabel = "İlerleme";
    String motivationLabel = "Motivasyon";
    String profileLabel = "Profil";
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ufo_green,
        elevation: 2,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: progessLabel,
            icon: const Icon(Icons.align_horizontal_left_rounded),
          ),
          BottomNavigationBarItem(
            label: motivationLabel,
            icon: const Icon(Icons.star_rounded),
          ),
          BottomNavigationBarItem(
            label: profileLabel,
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const TimeCounterPage(),
        );
      case 1:
        return RandomMessagePage();
      case 2:
        return _user != null ? ProfilePage(user: _user!) : Container();
      default:
        return Container();
    }
  }
}
