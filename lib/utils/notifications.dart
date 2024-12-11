// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// /// Initialize Notifications
// Future<void> initNotifications() async {
//   // Android Initialization
//   const AndroidInitializationSettings androidInitializationSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   // iOS Initialization (if needed)
//   const DarwinInitializationSettings darwinInitializationSettings =
//       DarwinInitializationSettings();

//   // Initialization Settings for all platforms
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: androidInitializationSettings,
//     iOS: darwinInitializationSettings,
//   );

//   // Initialize the plugin
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );

//   // Initialize time zones for scheduling notifications
//   tz.initializeTimeZones();
// }

// /// Schedule a Notification
// Future<void> scheduleNotification({
//   required String title,
//   required String body,
//   required DateTime scheduledTime,
// }) async {
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0, // Notification ID
//     title, // Notification Title
//     body, // Notification Body
//     tz.TZDateTime.from(scheduledTime, tz.local), // Scheduled Time
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'azkar_channel', // Channel ID
//         'Azkar Notifications', // Channel Name
//         channelDescription: 'Channel for Azkar reminders', // Description
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     ),
//     // androidAllowWhileIdle: true, // Ensure notification triggers even in Doze mode
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     androidScheduleMode:
//         AndroidScheduleMode.exactAllowWhileIdle, // Required parameter
//   );
// }

// /// Show an Instant Notification
// Future<void> showInstantNotification({
//   required String title,
//   required String body,
// }) async {
//   const NotificationDetails notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       'azkar_channel',
//       'Azkar Notifications',
//       channelDescription: 'Channel for Azkar reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//     ),
//     iOS: DarwinNotificationDetails(),
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0, // Notification ID
//     title,
//     body,
//     notificationDetails,
//   );
// }
