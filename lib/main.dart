import 'package:flutter/material.dart';
import 'package:task2/home.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'notification_helper.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
  initializeNotifications();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

