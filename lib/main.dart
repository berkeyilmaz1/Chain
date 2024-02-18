import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/newDailyclick.dart';
import 'package:schallange/constants/constants.dart';
import 'package:schallange/pages/Tabs/mainPage.dart';
import 'package:schallange/pages/authPages/loginPages.dart';
import 'package:schallange/pages/authPages/signUpPage.dart';
import 'package:schallange/pages/authPages/welcomePages.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/loginpage": (context) => const LoginPage(),
        "/signup": (context) => const signUpPage(),
        "/mainpage": (context) => const MainPage(),
        "/welcomepage": (context) => const WelcomePage(),
      },
      title: 'Sol-Chal24',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: newDailyClicker(),
    );
  }

  ThemeData themeData() => ThemeData(
          appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            letterSpacing: 2),
        backgroundColor: ufo_green,
        elevation: 2,
        titleSpacing: 6,
        shadowColor: Colors.black,
        centerTitle: true,
      ));
}
