import 'package:chat_app_2/views/register_screen.dart';
import 'package:chat_app_2/views/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/mybutton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = 'welcome_screen';
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Image.asset('assets/logo.jpg'),
                  height: 180,
                ),
                Text(
                  'Chat App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[900]),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    color: Colors.yellow[900]!,
                    title: 'Sign In',
                    onpressed: () {
                      Navigator.pushNamed(context, SignIn.route);
                    }),
                MyButton(
                    color: Colors.blue[900]!,
                    title: 'Register',
                    onpressed: () {
                      Navigator.pushNamed(context, Register.route);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
