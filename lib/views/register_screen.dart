import 'dart:io';

import 'package:chat_app_2/views/chat_screen.dart';
import 'package:chat_app_2/views/sign_in_screen.dart';
import 'package:chat_app_2/widgets/mybutton.dart';
import 'package:chat_app_2/widgets/picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  static const String route = 'register_screen';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool spinner = false;
  final auth = FirebaseAuth.instance;
  late String email;
  late String password;
  File? userImageFile;
  void imagePick(File pickedImage) {
    userImageFile = pickedImage;
  }

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
                          height: 25,
                        ),
                        ImagePick(imagePick),
                        const SizedBox(
                          height: 25,
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
                        // MyTextField('Enter your Email', email),
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
                              hintText: 'Enter your Password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10)),
                          onChanged: ((val) {
                            password = val;
                          }),
                        ),
                        // MyTextField(, password),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                            color: Colors.blue[900]!,
                            title: 'Register',
                            onpressed: () async {
                              // if (email.isEmpty || password.isEmpty) {
                              //   setState(() {
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(SnackBar(
                              //             content: Container(
                              //       child: Text(
                              //         'Please Enter a valid Email and Password!',
                              //         style: TextStyle(color: Colors.black),
                              //       ),
                              //       color: Colors.white,
                              //     )));
                              //   });
                              //   return;
                              // }
                        
                              setState(() {
                                spinner = true;
                              });
                              try {
                                final newuser =
                                    await auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(newuser.user!.uid)
                                    .set({'email': email, 'passord': password});
                                Navigator.pushNamed(context, Chat.route);
                                setState(() {
                                  spinner = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: (() {
                          
                               Navigator.pushNamed(context, SignIn.route);
                            }),
                            child: Text(
                              'Already have an account',
                              style: TextStyle(color: Colors.blue[800]),
                            ))
                        // MyButton(
                        //     color: Colors.white,
                        //     title: ,
                        //     onpressed: () {
                        //
                        //     })
                      ]),
                ),
              )),
        ));
  }
}
