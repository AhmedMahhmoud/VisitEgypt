import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:visit_egypt/Services/Push_Notifications/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../../Core/Constants/constants.dart';

class LocalNotification implements NotificationHandler {
  @override
  sendNotification(String title, String body) async {
    // Initialize the local notifications plugin
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Initialize the timezone package
    tz.initializeTimeZones();

    // Get the timezone for Cairo, Egypt
    tz.Location timeZone = tz.getLocation('Africa/Cairo');
    // Retrieve Timestamp from Firebase
    final snapshot = await FirebaseFirestore.instance
        .collection(Constants.notificationTime)
        .doc('timeDoc')
        .get();
    final firebaseTimestamp = snapshot.data()?['time'] as Timestamp?;
// Convert Timestamp to DateTime and then to TimeOfDay
    if (firebaseTimestamp != null) {
      final dateTime = firebaseTimestamp.toDate();
      final timeInCairo = tz.TZDateTime.from(dateTime, timeZone);
      print(timeInCairo.toString());
      tz.TZDateTime scheduledTime = tz.TZDateTime(
          timeZone,
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          timeInCairo.hour,
          timeInCairo.minute,
          timeInCairo.second,
          0);

      // Create a notification object
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'channel_id', 'channel_name',
          importance: Importance.max,
          priority: Priority.max,
          styleInformation: BigTextStyleInformation(''));

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0, // notification ID
          title, // notification title
          body, // notification body
          tz.TZDateTime.from(
              scheduledTime, tz.local), // scheduled date and time
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    }
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

//   tz.TZDateTime _scheduleDaily(Time time) {
//     final scheduledDate = tz.TZDateTime.now(tz.local).add(
//       const Duration(hours: 24),
//     );
//     final scheduledTime = tz.TZDateTime(
//       tz.getLocation('Africa/Cairo'),
//       scheduledDate.year,
//       scheduledDate.month,
//       scheduledDate.day,
//       13,
//     );

//     final date = tz.TZDateTime(
//         tz.local,
//         scheduledTime.year,
//         scheduledTime.month,
//         scheduledTime.day,
//         time.hour,
//         time.minute,
//         time.second);
//     return date.isBefore(scheduledTime)
//         ? date.add(const Duration(days: 1))
//         : date;
//     //check if it is not passed already
//   }
// }
}
