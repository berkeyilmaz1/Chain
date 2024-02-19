import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/myButton.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/components/myTextBox.dart';
import 'package:schallange/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
  });
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser!.email;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profil'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(
                FirebaseAuth.instance.currentUser!.uid) // Get current user's ID
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>?;
            var fullname = userData?['fullname'];
            var reason = userData?['reason'];
            var age = userData?['age'];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 175,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: width,
                    height: 304,
                    decoration: BoxDecoration(
                        color: ufo_green,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const MySizedBox(height: 20, widht: 0),
                          MyTextBox(boxName: "İsim-Soyisim", text: "$fullname"),
                          MyTextBox(boxName: "Yaş", text: "$age"),
                          MyTextBox(
                              boxName: "Neden Bırakmak İstiyorum",
                              text: "$reason"),
                        ],
                      ),
                    ),
                  ),
                ),
                Mybutton(
                  onPressed: () async {
                    // Sign out the user
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('/welcomepage');
                  },
                  buttonName: "Çıkış Yap",
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
