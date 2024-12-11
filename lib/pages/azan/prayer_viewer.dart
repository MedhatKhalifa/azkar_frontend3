// import 'package:flutter/material.dart';
// import 'package:adhan/adhan.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PrayerTimesPage extends StatefulWidget {
//   const PrayerTimesPage({super.key});

//   @override
//   _PrayerTimesPageState createState() => _PrayerTimesPageState();
// }

// class _PrayerTimesPageState extends State<PrayerTimesPage> {
//   List<String> prayerTimesList = [];
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     _getPrayerTimes();
//     // _initializeNotifications();
//   }

//   // Initialize notifications
//   Future<void> _initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   // Get current location and prayer times
//   void _getPrayerTimes() async {
//     // Position position = await Geolocator.getCurrentPosition(
//     //     desiredAccuracy: LocationAccuracy.high);

//     // // Use coordinates to calculate prayer times
//     // final coordinates = Coordinates(position.latitude, position.longitude);
//     //final coordinates = Coordinates(30.013447, 30.956787);
//     final coordinates = Coordinates(30.014916, 30.970089);
//     final params = CalculationMethod.egyptian.getParameters();
//     params.madhab = Madhab.shafi; // Adjust as necessary

//     final prayerTimes = PrayerTimes.today(coordinates, params);

//     setState(() {
//       prayerTimesList = [
//         DateFormat.jm().format(prayerTimes.fajr),
//         DateFormat.jm().format(prayerTimes.sunrise),
//         DateFormat.jm().format(prayerTimes.dhuhr),
//         DateFormat.jm().format(prayerTimes.asr),
//         DateFormat.jm().format(prayerTimes.maghrib),
//         DateFormat.jm().format(prayerTimes.isha),
//       ];
//     });

//     // Schedule notifications
//     // _scheduleNotifications(prayerTimes);
//   }

//   // // Schedule notifications for prayer times
//   // Future<void> _scheduleNotifications(PrayerTimes prayerTimes) async {
//   //   final notificationDetails = NotificationDetails(
//   //     android: AndroidNotificationDetails(
//   //       'prayer_channel',
//   //       'Prayer Notifications',
//   //       importance: Importance.high,
//   //       priority: Priority.high,
//   //     ),
//   //   );

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     0,
//   //     'Prayer Time',
//   //     'Fajr prayer is now',
//   //     TZDateTime.from(prayerTimes.fajr, tz.local),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //   );

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     1,
//   //     'Prayer Time',
//   //     'Dhuhr prayer is now',
//   //     TZDateTime.from(prayerTimes.dhuhr, tz.local),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //   );

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     2,
//   //     'Prayer Time',
//   //     'Asr prayer is now',
//   //     TZDateTime.from(prayerTimes.asr, tz.local),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //   );

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     3,
//   //     'Prayer Time',
//   //     'Maghrib prayer is now',
//   //     TZDateTime.from(prayerTimes.maghrib, tz.local),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //   );

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     4,
//   //     'Prayer Time',
//   //     'Isha prayer is now',
//   //     TZDateTime.from(prayerTimes.isha, tz.local),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.wallClockTime,
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Prayer Times'),
//         backgroundColor: Colors.teal,
//       ),
//       body: prayerTimesList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView.builder(
//                 itemCount: prayerTimesList.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 16),
//                       title: Text(
//                         prayerNames[index],
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal,
//                         ),
//                       ),
//                       subtitle: Text(
//                         prayerTimesList[index],
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }

//   final List<String> prayerNames = [
//     'Fajr',
//     'Sunrise',
//     'Dhuhr',
//     'Asr',
//     'Maghrib',
//     'Isha',
//   ];
// }
