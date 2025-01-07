import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mis/provider/joke_provider.dart';
import 'package:mis/screens/details.dart';
import 'package:mis/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:mis/services/api_service.dart';

// Initialize timezone data
Future<void> initializeTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = tz.local.name;
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

// Schedule a notification for the joke of the day
Future<void> scheduleJokeOfTheDayNotification() async {
  // Fetch the joke of the day
  String jokeOfTheDay = await ApiService.getRandomJoke();

  // Schedule notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID
    'Joke of the Day', // Notification title
    jokeOfTheDay, // Notification body
    _nextInstanceOf2PM(),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Replace androidAllowWhileIdle
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time, // Trigger daily at the same time
  );
}

// Helper function to calculate next 2 PM
tz.TZDateTime _nextInstanceOf2PM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 14, 32);

  if (scheduledDate.isBefore(now)) {
    // If 2 PM has already passed, schedule for the next day
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  print("Scheduled date for notification: $scheduledDate");

  return scheduledDate;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background notifications here (if needed)
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  await notificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request notification permissions
  messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Retrieve FCM token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Initialize notification system
  await initializeTimeZone();
  await initializeNotifications();
  await createNotificationChannel();

  // Schedule daily notification
  await scheduleJokeOfTheDayNotification();

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            '@mipmap/ic_launcher',
            'High Importance Notifications',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    }
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke Types',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/details': (context) => const Details(),
      },
    );
  }
}
