import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:vou/core/di/service_locator.dart';

import '../../features/event/domain/entities/event_model.dart';
import '../storage/hive_service.dart';

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();
  static late HiveService service;

  static int generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  static Future<void> init() async {
    const androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    service = $serviceLocator<HiveService>();

    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _notification.initialize(initSettings);

    _notification
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> cancelNotification(int notificationId) async {
    await _notification.cancel(notificationId);
    debugPrint("Notification with ID $notificationId has been canceled.");
  }

  static Future<void> pushNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'important_channel',
      'My Channel',
      channelDescription: 'This channel is for important notifications.',
      importance: Importance.max,
      priority: Priority.max,
    );

    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notification.show(
      generateNotificationId(),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> scheduleEventNotifications({
    required EventModel event,
    required HiveService hiveService,
  }) async {
    final int startNotificationId = generateNotificationId();
    final int endNotificationId = generateNotificationId();

    const androidDetails = AndroidNotificationDetails(
      'important_channel',
      'My Channel',
      channelDescription: 'This channel is for important notifications.',
      importance: Importance.max,
      priority: Priority.max,
    );

    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notification.zonedSchedule(
      0,
      "Reminder set for: ${event.name}",
      event.description,
      tz.TZDateTime.from(DateTime.now(), tz.local).add(const Duration(seconds: 5)),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    // Schedule notification 1 day before the start date
    final startDateNotificationTime = tz.TZDateTime.from(event.startDate, tz.local).subtract(const Duration(days: 1));
    await _notification.zonedSchedule(
      startNotificationId,
      "Reminder: ${event.name} is starting soon",
      event.description,
      startDateNotificationTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    // Schedule notification 1 day before the end date
    final endDateNotificationTime = tz.TZDateTime.from(event.endDate, tz.local).subtract(Duration(days: 1));
    await _notification.zonedSchedule(
      endNotificationId,
      "Reminder: ${event.name} is ending soon",
      event.description,
      endDateNotificationTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    // Save notification IDs mapped to the event ID in Hive
    await hiveService.save(event.id, [startNotificationId, endNotificationId]);
  }

  static Future<void> cancelEventNotifications({
    required String eventId,
  }) async {
    final notificationIds = service.get(eventId);
    if (notificationIds != null && notificationIds is List<int>) {
      for (final id in notificationIds) {
        await cancelNotification(id);
      }
      await service.delete(eventId);
    }
  }
}
