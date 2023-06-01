import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:visit_egypt/Services/Push_Notifications/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotification implements NotificationHandler {
  @override
  sendNotification(String title, String body) async {
    final notification = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    await notification.zonedSchedule(0, title, body,
        _scheduleDaily(const Time(9)), await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
    print('notification scheduled');
  }

  Future<void> showNotification(String title, String body) async {
    // Create the notification details
    final notification = FlutterLocalNotificationsPlugin();

    // Show the notification
    await notification.show(0, title, body, await _notificationDetails());
  }

  Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'visit_egypt channel', 'visit_egypt',
            importance: Importance.max, priority: Priority.max));
  }

  tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final date = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return date.isBefore(now) ? date.add(const Duration(days: 1)) : date;
    //check if it is not passed already
  }
}
