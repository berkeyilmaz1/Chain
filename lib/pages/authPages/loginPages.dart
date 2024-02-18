import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/myButton.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/components/myTextField.dart';
import 'package:schallange/constants/constants.dart';
import 'package:schallange/pages/authPages/signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    late String email;
    late String password;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ufo_green,
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
                flex: 6,
                child: Container(
                  width: width,
                  decoration: kBoxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SignUpTitle(
                          titleName: "Giriş Yap", routeName: "/welcomepage"),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            const MySizedBox(height: 30, widht: 0),
                            CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bilgileri Eksizsiz Doldurunuz!";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                                name: "E-mail",
                                obscureText: false),
                            const MySizedBox(height: 30, widht: 0),
                            CustomTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Bilgileri Eksizsiz Doldurunuz!";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value!;
                                },
                                name: "Şifre",
                                obscureText: true),
                            const MySizedBox(height: 36, widht: 0),
                            SizedBox(
                                width: 300,
                                height: 40,
                                child: Mybutton(
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        formkey.currentState!.save();
                                        try {
                                          final userRes = await firebaseAuth
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                          Navigator.pushReplacementNamed(
                                              context, "/mainpage");
                                          print(userRes.user?.email);
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      }
                                    },
                                    buttonName: "Giriş Yap")),
                            const MySizedBox(height: 20, widht: 0),
                            const forgotPassword(),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class forgotPassword extends StatelessWidget {
  const forgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Şifremi Unuttum",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
