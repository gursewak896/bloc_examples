import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    // 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Hello',
    'Flutter Local Notifications',
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> scheduleNotification(int minutes) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    // 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,// Ensure this parameter is used
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Scheduled Notification',
    'This notification is scheduled to appear in $minutes minutes',
    _nextInstanceOfMinutes(minutes),
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    androidAllowWhileIdle: true, // Ensure this is set in zonedSchedule
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    payload: 'Scheduled Notification',
  );
}

tz.TZDateTime _nextInstanceOfMinutes(int minutes) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  return now.add(Duration(minutes: minutes));
}
