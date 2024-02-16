import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/myButton.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/components/myTile.dart';
import 'package:schallange/constants/constants.dart';

// ignore: camel_case_types
class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

// ignore: camel_case_types
class _signUpPageState extends State<signUpPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  List<String> items = [
    'Sigara',
    'Alkol',
    'Kumar',
    'Sosyal Medya',
    'Teknolji',
    'Oyun',
    'Fast-Food',
  ];
  String? selectedItem = 'Sigara';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String titleName2 = "Hadi Başlayalım";
    String warning = "Bilgileri Eksizsiz Doldurunuz!";

    String emailTitle = "E-mail";
    String passwordTitle = "Şifre";
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
                      children: <Widget>[
                        SignUpTitle(
                            titleName: titleName2, routeName: "/welcomepage"),
                        const MySizedBox(height: 5, widht: 0),
                        Padding(
                          padding: kPadding24,
                          child: Column(
                            children: [
                              CostumTile(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return warning;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                                name: emailTitle,
                                obscureText: false,
                              ),
                              const MySizedBox(height: 30, widht: 0),
                              CostumTile(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return warning;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value!;
                                },
                                name: passwordTitle,
                                obscureText: true,
                              ),
                              const MySizedBox(height: 30, widht: 0),
                              const CostumTile(
                                name: "Neden Yapıyorum",
                                obscureText: false,
                              ),
                              const MySizedBox(height: 30, widht: 0),
                              SizedBox(
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.60,
                                      height: 50,
                                      child: Text(
                                        "Hangi Bağımlılıktan Kurtulmak İstiyorsun",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                    const MySizedBox(height: 0, widht: 5),
                                    mydropDownButton(),
                                    const MySizedBox(height: 0, widht: 5),
                                  ],
                                ),
                              ),
                              const MySizedBox(height: 30, widht: 0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                      height: 40,
                                      child: Mybutton(
                                          // Inside the onPressed of Mybutton widget in signUpPage
                                          onPressed: () async {
                                            if (formkey.currentState!
                                                .validate()) {
                                              formkey.currentState!.save();
                                              try {
                                                var userResult = await firebaseAuth
                                                    .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                );

                                                formkey.currentState!.reset();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Kayıt Olundu. Ana Sayfaya Yönlendiriliyorsunuz."),
                                                ));

                                                // Navigate to the main page after successful registration
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/mainpage');
                                              } catch (e) {
                                                print(e.toString());
                                              }
                                            }
                                          },
                                          buttonName: "Kayıt Ol")),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  DropdownButton<String> mydropDownButton() {
    return DropdownButton<String>(
        value: selectedItem,
        items: items
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kTextStyle,
                )))
            .toList(),
        onChanged: (item) => setState(() {
              selectedItem = item;
            }));
  }
}

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({
    super.key,
    required this.titleName,
    required this.routeName,
  });
  final String titleName;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(routeName);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const SizedBox(
            width: 30,
          ),
          Center(
              child: Text(
            titleName,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ))
        ],
      ),
    );
  }
}
