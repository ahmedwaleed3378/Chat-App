import 'package:chat_app_2/views/chat_screen.dart';
import 'package:chat_app_2/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/mybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  static const String route = 'signin_screen';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool spinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: spinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          child: Image.asset('assets/logo.jpg'),
                          height: 180,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Enter your Email',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10)),
                          onChanged: ((val) {
                            email = val;
                          }),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Enter your password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10)),
                          onChanged: ((val) {
                            password = val;
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                            color: Colors.orange,
                            title: 'Sign In',
                            onpressed: () async {
                              setState(() {
                                spinner = true;
                              });
                              try {
                                final realuser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (realuser != null) {
                                  Navigator.pushNamed(context, Chat.route);
                                  setState(() {
                                    spinner = false;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Register.route);
                            },
                            child: Text('Create an account',
                                style: TextStyle(color: Colors.blue[800])))
                        // MyButton(
                        //     color: Colors.white,
                        //     title: ,
                        //     onpressed: () {
                        //     })
                      ]),
                ),
              ),
            )));
  }
}
