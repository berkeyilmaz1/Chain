import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/constants/constants.dart';
import 'package:schallange/pages/Tabs/activityPage.dart';
import 'package:schallange/pages/Tabs/motivation.dart';
import 'package:schallange/pages/Tabs/profile.dart';
import 'package:schallange/pages/Tabs/timecounter.dart';

class MainPage extends StatefulWidget {
  final String? selectedItem;

  const MainPage({super.key, this.selectedItem});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late User? _user;
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _selectedItem = widget.selectedItem ?? '';
  }

  @override
  Widget build(BuildContext context) {
    String progessLabel = "İlerleme";
    String motivationLabel = "Motivasyon";
    String profileLabel = "Profil";
    String activityLabel = "Aktivitelerim";
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: ufo_green,
        color: Colors.white,
        items: [
          TabItem(
              icon: Icons.align_horizontal_left_rounded, title: progessLabel),
          TabItem(icon: Icons.local_activity_rounded, title: activityLabel),
          TabItem(icon: Icons.star_rounded, title: motivationLabel),
          TabItem(icon: Icons.person, title: profileLabel),
        ],
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        initialActiveIndex: _currentIndex, // Başlangıçta seçilen endeksi belirt
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const TimeCounterPage();
      case 1:
        return const ActivityPage();
      case 2:
        return const RandomMessagePage();
      case 3:
        return ProfilePage();
      default:
        return Container();
    }
  }
}
