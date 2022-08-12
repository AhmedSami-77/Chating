import 'package:chat_application/componant/costum_button.dart';
import 'package:chat_application/constant/coloers.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componant/costum_text_feild.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registraion';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _eamilController = TextEditingController();
  TextEditingController _passowredController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                      color: ConstanColoers.primary300,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/coffee-talk-chat-bubble-forum-logo-vector-icon-illustration_7688-3123.webp',
                fit: BoxFit.cover,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CostumTextField(
                        controller: _fullNameController,
                        hentText: 'Enter your full name',
                        lableText: 'Full name',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CostumTextField(
                        controller: _eamilController,
                        hentText: 'ahmed@gmail.com',
                        lableText: 'Email',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CostumTextField(
                        obscureText: _obscureText,
                        isPassowred: true,
                        suffixIconFunction: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        controller: _passowredController,
                        hentText: '123456789abCD##',
                        lableText: 'Passowrd',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CostumTextField(
                        controller: _phoneNumberController,
                        hentText: 'Enter your phone number',
                        lableText: 'Phone number',
                        isPhoneNumber: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CostumButton(
                        color: ConstanColoers.primary,
                        title: 'Registar',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final _newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _eamilController.text,
                                      password: _passowredController.text);
                              Navigator.pushNamed(context, ChatScreen.id);
                            } catch (error) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(error.toString()),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
