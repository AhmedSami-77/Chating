import 'package:chat_application/componant/costum_button.dart';
import 'package:chat_application/constant/coloers.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../componant/costum_text_feild.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'sign_in';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _eamilController = TextEditingController();
  TextEditingController _passowredController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/coffee-talk-chat-bubble-forum-logo-vector-icon-illustration_7688-3123.webp',
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                      CostumButton(
                          color: ConstanColoers.primary,
                          title: 'Login',
                          onPressed: () async {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _eamilController.text,
                                      password: _passowredController.text);
                              if (user != null) {
                                Navigator.pushNamed(context, ChatScreen.id);
                              }
                            } catch (error) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(error.toString()),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
