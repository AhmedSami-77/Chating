import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/registration_screen.dart';
import 'package:chat_application/screens/sign_in_screen.dart';
import 'package:chat_application/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chating',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          _auth.currentUser == null ? WelcomeScreen.id : ChatScreen.id,
      routes: {
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
