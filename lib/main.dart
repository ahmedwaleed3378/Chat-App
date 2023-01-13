import 'dart:ui';

import 'package:chat_app_2/views/chat_screen.dart';
import 'package:chat_app_2/views/register_screen.dart';
import 'package:chat_app_2/views/sign_in_screen.dart';
import 'package:chat_app_2/views/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: auth.currentUser != null ? Chat.route : WelcomeScreen.route,
      routes: {
        WelcomeScreen.route: ((context) => WelcomeScreen()),
        SignIn.route: ((context) => const SignIn()),
        Register.route: ((context) => const Register()),
        Chat.route: ((context) => const Chat()),
      },
    );
  }
}
