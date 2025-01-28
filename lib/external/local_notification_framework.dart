import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/standalone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Map<int, tz.TZDateTime> scheduledNotifications = {};

Future<void> initiateLocalNotifications() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void showNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0, // ID único da notificação
    'Título',
    'Mensagem da notificação',
    notificationDetails,
  );
}

Future<int> scheduleNotificationAuxiliary(
    String title, String description, DateTime scheduleHourNotification) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.max,
  );

  if (await Permission.scheduleExactAlarm.request().isGranted) {
    print('Permission granted');
  } else {
    print('Permission denied');
    return(-1);
  }

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      scheduleHourNotification, tz.getLocation('America/Sao_Paulo'));

  final Random random = Random();
  final int id = random.nextInt(1 <<
      31); // ultimo frufru só garante que sera no maximo o tamanho de um inteiro;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id, // ID único da notificação
    title,
    description,
    scheduledDate,
    notificationDetails,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );

  scheduledNotifications[id] = scheduledDate;
  return id;
}

Future<void> showPendingNotifications() async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  for (var pendingNotification in pendingNotificationRequests) {
    final scheduledDate = scheduledNotifications[pendingNotification.id];
    if (scheduledDate != null) {
      final Duration timeRemaining = scheduledDate
          .difference(tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo')));
      print(
          'ID: ${pendingNotification.id}, Title: ${pendingNotification.title}, Body: ${pendingNotification.body}, Time Remaining: ${timeRemaining.inSeconds} seconds');
    } else {
      print(
          'ID: ${pendingNotification.id}, Title: ${pendingNotification.title}, Body: ${pendingNotification.body}, Scheduled Date: Not Found');
    }
  }
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

class NotificationManager {
  final String name;
  final Map<String, int> notifications;

  NotificationManager({required this.name, Map<String, int>? notifications})
      : notifications = notifications ?? {};

  getScheduledNotification(String key) {
    return notifications[key];
  }

  void cancelNotification(String key) {
    final notificationId = notifications[key];
    if (notificationId != null) {
      flutterLocalNotificationsPlugin.cancel(notificationId);
    } else {
      throw Exception('Notification not found');
    }
  }

  void scheduleNotification(String key, String title, String description,
      DateTime scheduleHourNotification) async {
    final notificationId = await scheduleNotificationAuxiliary(
        title, description, scheduleHourNotification);
    notifications[key] = notificationId;
  }

  void printNotificationManager() {
    print('Notification Manager: $name');
    for (var key in notifications.keys) {
      print('Key: $key, Notification ID: ${notifications[key]}');
    }
  }
}
