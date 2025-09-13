import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../ui/pages/notification_screen.dart';

// استبدل بالمسار الصحيح لصفحة التفاصيل عندك

class NotifyHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// ==== INITIALIZE: تهيئة المكتبة + ضبط timezone ====
  Future<void> initializeNotification() async {
    // تهيئة قاعدة بيانات المناطق الزمنية

    // حاول نضبط المنطقة الزمنية المحلية (مفيد لو عايز scheduling دقيق)
    try {} catch (e) {
      debugPrint('Could not get local timezone: $e');
      // لو فشل نترك tz.local كما هو (عادة UTC) — لكن يفضل تثبيت flutter_native_timezone
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          'appicon',
        ); // اسم resource في android/res/drawable بدون .png

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    // نهيئ المكون ونمرر handler منفصل للتعامل مع الضغط على الإشعار
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: handleNotificationResponse,
    );
  }

  /// ==== HANDLER: لما المستخدم يضغط على الإشعار ====
  void handleNotificationResponse(NotificationResponse response) {
    final payload = response.payload ?? '';
    debugPrint('Notification clicked: $payload');

    if (payload.isNotEmpty) {
      // افتح الصفحة المطلوبة عبر Get (لا تحتاج context)
      // NotificationScreen مفترض ياخد String اسمه notificationLoad
      Get.to(() => NotificationScreen(notificationLoad: payload));
    } else {
      debugPrint('⚠️ No payload found, cannot navigate.');
    }
  }

  /// ==== SHOW: إظهار إشعار فوري ====
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
    int? id,
  }) async {
    final int notifId =
        id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'your_channel_id', // غيّر حسب مشروعك
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,

          // لو عندك أي إعدادات إضافية ضيفها هنا
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notifId,
      title,
      body,
      platformDetails,
      payload: payload ?? '',
    );
  }

  /// ==== SCHEDULE: جدولة إشعار بعد عدد دقائق معين (الافتراضي 5 دقائق) ====
}
