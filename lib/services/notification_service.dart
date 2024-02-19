import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));

    notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
      ?..requestNotificationsPermission()
      ..requestExactAlarmsPermission();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_logo');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {});
  }

  static notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'desc',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }

  Future scheduleNotification(
      {required int id,
      required String title,
      required String body,
      String? payload,
      required DateTime schedultTime}) async {
    await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(schedultTime, tz.local).subtract(const Duration(minutes: 10)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'ch2', 'Schedule channel',
                channelDescription: 'Dedicated to scheduled notifications',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  Future cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }
}
