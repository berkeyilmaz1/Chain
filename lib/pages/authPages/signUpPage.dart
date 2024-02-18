import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schallange/components/myButton.dart';
import 'package:schallange/components/mySizedBox.dart';
import 'package:schallange/components/myTextField.dart';
import 'package:schallange/constants/constants.dart';
import 'package:schallange/pages/Tabs/mainPage.dart';

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
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  Future<void> addUserDetails(String fullname, String reason, int age) async {
  // Get the current user's ID
  String userId = FirebaseAuth.instance.currentUser!.uid;
  
  // Store user information in Firestore
  await FirebaseFirestore.instance.collection("users").doc(userId).set({
    'fullname': fullname,
    'reason': reason,
    'age': age,
  });
}

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
                              CustomTextField(
                                  controllerName: fullNameController,
                                  name: "İsim-Soyisim",
                                  obscureText: false),
                              CustomTextField(
                                  controllerName: ageController,
                                  name: "Yaş",
                                  obscureText: false),
                              const MySizedBox(height: 15, widht: 0),
                              CustomTextField(
                                  controllerName: reasonController,
                                  name: "Neden Bırakmak İstiyorum?",
                                  obscureText: false),
                              const MySizedBox(height: 15, widht: 0),
                              CustomTextField(
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
                              const MySizedBox(height: 15, widht: 0),
                              CustomTextField(
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
                              const MySizedBox(height: 15, widht: 0),
                              SizedBox(
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Hangi Bağımlılıktan Kurtulmak İstiyorsun",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                    mydropDownButton(),
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
                                          onPressed: () async {
                                            if (formkey.currentState!
                                                .validate()) {
                                              formkey.currentState!.save();
                                              try {
                                                // ignore: unused_local_variable
                                                var userResult = await firebaseAuth
                                                    .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                );
                                                addUserDetails(
                                                    fullNameController.text
                                                        .trim(),
                                                    reasonController.text
                                                        .trim(),
                                                    int.parse(ageController.text
                                                        .trim()));
                                                formkey.currentState!.reset();
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Kayıt Olundu. Ana Sayfaya Yönlendiriliyorsunuz."),
                                                ));
          
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage(),
                                                  ),
                                                );
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
