import 'package:chat_application/componant/costum_button.dart';
import 'package:chat_application/screens/registration_screen.dart';
import 'package:chat_application/screens/sign_in_screen.dart';

import '../constant/coloers.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcom';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: _size.height,
              width: _size.width,
              child: Image.asset(
                'assets/images/coffee-talk-logo-design-vector-coffee-cup-chat-speech-bubble-icon_445285-487.webp',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: _size.height * .1,
              right: _size.width * .1,
              left: _size.width * .1,
              child: Column(
                children: [
                  CostumButton(
                    color: ConstanColoers.primary,
                    title: 'Sign in',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CostumButton(
                    color: ConstanColoers.primary,
                    title: 'Registration',
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
