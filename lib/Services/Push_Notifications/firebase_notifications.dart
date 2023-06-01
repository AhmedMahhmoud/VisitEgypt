import 'dart:convert';
import 'dart:developer';

import 'package:visit_egypt/Services/Push_Notifications/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseRemoteNotification implements NotificationHandler {
  final fbMsg = FirebaseMessaging.instance;
  String serverToken =
      'AAAARXpKLCc:APA91bGaUtFeY3dAWeTWZJYahNikVJ5bUPATaHHhiy-ZOpeBXnnsQjaOcqMQMTVNi5hVrNLbF5lrLbG3vIK3rfR6WqY567yFy_W-L7YdCao9uc5NzH8pjodLuLbFZsUDxDGDxbgBSmGH';
  @override
  sendNotification(String title, String body, [token]) async {
    try {
      const url = 'https://fcm.googleapis.com/fcm/send';
      final header = {
        "Content-Type": "application/json",
        "Authorization": "key=$serverToken",
      };
      Map<String, dynamic> request;

      request = {
        "notification": {
          "title": title,
          "body": body,
          "content_available": true,
          // "text": message,
        },
        "data": {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          "title": title,
          "body": body,
        },
        "priority": "high",
        "to": token
      };

//    "to": "$toParams",

      final client = http.Client();
      final response = await client.post(Uri.parse(url),
          headers: header, body: json.encode(request));
      log("fcm response ${response.body}");
      // Provider.of<UserData>(navigatorKey.currentState.overlay.context,
      //         listen: false)
      //     .addNotificationRequestID(DateTime.now().millisecond);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getFcmToken() async {
    return await fbMsg.getToken();
  }
}
