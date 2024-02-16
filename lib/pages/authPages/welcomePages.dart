import 'package:flutter/material.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';
import 'package:schallange/pages/authPages/loginPages.dart';
import 'package:schallange/pages/authPages/signUpPage.dart';
import '../../components/myButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 300, height: 300, child: Image.asset("images/logo.png",)),
              const MySizedBox(height: 20, widht: 0),
              SizedBox(
                  width: width * 0.60,
                  child: const Text(
                    appTexts.welcome2,
                    style: kWelcomeTextStyle,
                    textAlign: TextAlign.center,
                  )),
              const MySizedBox(
                height: 100,
                widht: 0,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: Mybutton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const signUpPage(),
                      ));
                    },
                    buttonName: "Başlayalım !"),
              ),
              const MySizedBox(
                height: 10,
                widht: 0,
              ),
              MyTextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
                name: "Zaten bir hesabım var.",
              )
            ],
          ),
        ),
      ),
    );
  }
}
