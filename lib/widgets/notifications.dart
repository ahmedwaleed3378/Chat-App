// import 'package:flutter/material.dart';
// import "package:flutter_local_notifications/flutter_local_notifications.dart";

// class Notification {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   Future<void> intialize() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@drawable/ic_launcher.png');

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true,
//             onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iosInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: _onSelectNotification);
//   }

//   Future<NotificationDetails?> notificationdetails() async {
//     const AndroidNotificationDetails androiddetails =
//         AndroidNotificationDetails('channelId', 'channelName',
//             channelDescription: 'Description',
//             priority: Priority.max,
//             importance: Importance.max,
//             playSound: true);
//     const IOSNotificationDetails IOSdetails = IOSNotificationDetails();
//     return NotificationDetails(android: androiddetails, iOS: IOSdetails);
//   }

//   Future<void> shownotification(
//       {required int id, required String title, required String body}) async {
//     final details = await notificationdetails();
//     await flutterLocalNotificationsPlugin.show(
//         id, title, body, details);
//   }

//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print(id);
//   }

//   void _onSelectNotification(String? payload) {
//     print(payload);
//   }
// }
