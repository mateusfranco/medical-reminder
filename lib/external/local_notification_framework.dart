import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/standalone.dart' as tz;

Future<void> initiateLocalNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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

void scheduleNotification() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.max,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  final tz.TZDateTime scheduledDate =
      tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo')).add(const Duration(seconds: 10));

  await flutterLocalNotificationsPlugin.zonedSchedule(
    123, // ID único da notificação
    'teste',
    'notificação agendada',
    // Agendar para daqui a 5 segundos
    scheduledDate, // Agendar para daqui a 5 segundos
    notificationDetails,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exact,
  );

  scheduledNotifications[0] = scheduledDate;
}

Map<int, tz.TZDateTime> scheduledNotifications = {};

Future<void> showPendingNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  for (var pendingNotification in pendingNotificationRequests) {
    final tz.TZDateTime? scheduledDate = scheduledNotifications[pendingNotification.id];
    if (scheduledDate != null) {
      final Duration timeRemaining = scheduledDate.difference(tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo')));
      print('ID: ${pendingNotification.id}, Title: ${pendingNotification.title}, Body: ${pendingNotification.body}, Time Remaining: ${timeRemaining.inSeconds} seconds');
    } else {
      print('ID: ${pendingNotification.id}, Title: ${pendingNotification.title}, Body: ${pendingNotification.body}, Scheduled Date: Not Found');
    }
  }
}