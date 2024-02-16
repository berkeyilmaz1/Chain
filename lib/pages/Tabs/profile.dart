import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  final User? user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: const BoxDecoration(
              color: ufo_green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          width: width,
          height: height,
          child: Column(
            children: [
              const Icon(
                Icons.person,
                size: 250,
              ),
              const MySizedBox(height: 30, widht: 0),
              const Text(
                "E-mail:",
                style: kTextStyle,
              ),
              Container(
                width: width * 0.50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Center(
                  child: Text(
                    '${user?.email}',
                    style: kTextStyle.copyWith(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  // Sign out the user
                  await FirebaseAuth.instance.signOut();
                  // Navigate back to the login page
                  Navigator.of(context).pushReplacementNamed('/loginpage');
                },
                child: const Text(
                  'Çıkış Yap',
                  style: kTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
