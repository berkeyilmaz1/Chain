import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/myButton.dart';
import 'package:schallange/components/myTextBox.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
  });
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
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
                  size: 200,
                ),
                MyTextBox(boxName: "İsim-Soyisim", text: "$fullname"),
                MyTextBox(boxName: "Yaş", text: "$age"),
                MyTextBox(
                    boxName: "Neden Bırakmak İstiyorum", text: "$reason"),
                Mybutton(
                  onPressed: () async {
                    // Sign out the user
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('/loginpage');
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
