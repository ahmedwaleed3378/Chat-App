import 'package:chat_app_2/views/sign_in_screen.dart';
import 'package:chat_app_2/views/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late User signedInuser;

class Chat extends StatefulWidget {
  static const String route = 'chat_screen';
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String? messageText;

  final _store = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final TextEditingController messagecontroller = TextEditingController();
  //late final FlutterLocalNotificationsPlugin service;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // service = FlutterLocalNotificationsPlugin();
    //service.initialize();
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        signedInuser = user;
        print(signedInuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _store.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void getStreamMessages() async {
  //   await for (var snapshot in _store.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.route);
              },
              icon: const Icon(Icons.close))
        ],
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Chat App')
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyStream(_store),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  controller: messagecontroller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your message here...',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  onChanged: ((value) {
                    messageText = value;
                  }),
                )),
                TextButton(
                    onPressed: () {
                      _store.collection('messages').add({
                        'text': messageText,
                        'sender': signedInuser.email,
                        'time': FieldValue.serverTimestamp()
                      });
                      messagecontroller.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text('send',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 18)))
              ],
            ),
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 2, color: Colors.orange))),
          )
        ],
      )),
    );
  }
}

class MyStream extends StatelessWidget {
  const MyStream(
    this.store,
  );
  final store;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: store.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messagesWidget = [];
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final text = message.get('text');
            final sender = message.get('sender');
            final current = signedInuser.email;
            if (current == sender) {
              //
            }
            final messageWidget = MessageLine(
              sender: sender,
              text: text,
              isCurrent: current == sender,
            );
            messagesWidget.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagesWidget,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine(
      {Key? key,
      required this.sender,
      required this.text,
      required this.isCurrent})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.yellow[900]),
          ),
          Material(
            elevation: 5,
            borderRadius: isCurrent
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isCurrent ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    color: isCurrent ? Colors.white : Colors.blue[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
