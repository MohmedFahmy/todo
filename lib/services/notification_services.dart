import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/ui/pages/notification_screen.dart';

class NotifyHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  /// تهيئة الإشعارات
  Future<void> initializeNotification() async {
    tz.initializeTimeZones();
    await _configureLocalTimeZone();
    _configureSelectNotificationSubject();

    const androidSettings = AndroidInitializationSettings('appicon');
    const darwinSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
            final String? payload = notificationResponse.payload;
            if (payload != null) {
              debugPrint('Notification payload: $payload');
              selectNotificationSubject.add(payload);
            }
          },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  /// Notification tap handler in background
  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    debugPrint('Notification tapped in background: ${response.payload}');
  }

  /// إشعار فوري
  Future<void> displayNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: 'Default_Sound',
    );
  }

  /// إشعار مجدول بعد مدة (بالثواني)
  Future<void> scheduleNotificationAfterDelay({
    required String title,
    required String body,
    required int seconds,
  }) async {
    try {
      final tz.TZDateTime scheduledDate = tz.TZDateTime.now(
        tz.local,
      ).add(Duration(seconds: seconds));

      await flutterLocalNotificationsPlugin.zonedSchedule(
        DateTime.now().millisecondsSinceEpoch.remainder(100000), // ID فريد
        title,
        body,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: '$title|$body|${scheduledDate.toIso8601String()}',
      );
    } catch (e) {
      debugPrint("⚠️ فشل جدولة الإشعار: $e");
      if (Platform.isAndroid) {
        await requestExactAlarmPermission();
      }
    }
  }

  /// إعداد المنطقة الزمنية
  Future<void> _configureLocalTimeZone() async {
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  /// استقبال الضغط على الإشعارات
  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is $payload');
      await Get.to(
        () => NotificationScreen(payload, notificationLoad: payload),
      );
    });
  }
}

/// طلب صلاحية Exact Alarm لأندرويد 12+
Future<void> requestExactAlarmPermission() async {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );
    await intent.launch();
  }
}
