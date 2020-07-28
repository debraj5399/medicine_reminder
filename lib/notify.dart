// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// void main() async {
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {


//   String _toTwoDigitString(int value) {
//     return value.toString().padLeft(2, '0');
//   }



//   FlutterLocalNotificationsPlugin localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   initializeNotifications() async {
//     var initializeAndroid = AndroidInitializationSettings('ic_launcher');
//     var initializeIOS = IOSInitializationSettings();
//     var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
//     await localNotificationsPlugin.initialize(initSettings);
//   }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   initializeNotifications();
//   // }


//     Future<void> _showWeeklyAtDayAndTime() async {
//     var time = Time(16, 3, 0);
//      var times = Time(16, 5, 0);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'show weekly channel id',
//         'show weekly channel name',
//         'show weekly description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//         3,
//         'show weekly title',
//         'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//         Day.Sunday,
//         time,
//         platformChannelSpecifics);
//          await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//         4,
//         'show weekly title',
//         'Weekly notification shown on Monday at approximately ${_toTwoDigitString(times.hour)}:${_toTwoDigitString(times.minute)}:${_toTwoDigitString(times.second)}',
//         Day.Sunday,
//         times,
//         platformChannelSpecifics);
//   }

//   Future singleNotification(
//       DateTime datetime, String message, String subtext, int hashcode,
//       {String sound}) async {
//     var androidChannel = AndroidNotificationDetails(
//       'channel-id',
//       'channel-name',
//       'channel-description',
//       importance: Importance.Max,
//       priority: Priority.Max,
//     );

//     var iosChannel = IOSNotificationDetails();
//     var platformChannel = NotificationDetails(androidChannel, iosChannel);
//     localNotificationsPlugin.schedule(
//         hashcode, message, subtext, datetime, platformChannel,
//         payload: hashcode.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification/Alarm Example'),
//       ),
//       body: Center(
//         child: Container(
//           child: Text('Notification App'),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.notifications),
//         onPressed: () async {

//           //By this is how you can get notification on a sch time
//           // DateTime now= DateTime.parse("2019-09-08 14:44:00.000000");

// await _showWeeklyAtDayAndTime();
//           //     print(now);
//           // await singleNotification(
//           //   now,
//           //   "Notification",
//           //   "This is a notification",
//           //   98123871,
//           // );
//         },
//       ),
//     );
//   }
// }
