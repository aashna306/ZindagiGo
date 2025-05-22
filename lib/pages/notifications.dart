import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import '../../main.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
  
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static int? tappedNotificationId;
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload ?? "";
    tappedNotificationId = response.id;
    final parts = payload.split('|');
    if (parts.length < 3) return;

    final String title = parts[0];
    final String body = parts[1];
    final int snoozeDuration = int.tryParse(parts[2]) ?? 0;

    // Update HomePage if open
    if (HomePage.globalKey.currentState != null) {
      HomePage.globalKey.currentState!.updateFromPayload("$title|$body");
    } else {
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => HomePage(payload: "$title|$body"),
      ));
    }

    // Schedule next notification after snoozeDuration minutes
    final DateTime nextTime =
        DateTime.now().add(Duration(minutes: snoozeDuration));

    scheduleNotification(
      id: response.id ?? 0,
      title: title,
      body: body,
      scheduledTime: nextTime,
      snoozeDuration: snoozeDuration,
    );
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int snoozeDuration,
  }) async {
    final payload = "$title|$body|$snoozeDuration";

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'This channel is used for reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
