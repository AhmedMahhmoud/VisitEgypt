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
    final scheduledDate = tz.TZDateTime.now(tz.local).add(
      const Duration(hours: 24),
    );
    final scheduledTime = tz.TZDateTime(
      tz.getLocation('Africa/Cairo'),
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      13,
    );

    final date = tz.TZDateTime(
        tz.local,
        scheduledTime.year,
        scheduledTime.month,
        scheduledTime.day,
        time.hour,
        time.minute,
        time.second);
    return date.isBefore(scheduledTime)
        ? date.add(const Duration(days: 1))
        : date;
    //check if it is not passed already
  }
}
