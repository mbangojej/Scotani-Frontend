import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ));

    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = await DateTime.now().millisecondsSinceEpoch ~/ 1000;
      String? payloadId = message.data['_id'] as String?;
      print("Paylod Data ${payloadId}");
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "scotani_push_notification",
          "scotanipushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );
      Map<String, dynamic> data = message.data;
      if (data['logout'] != null) {
        print('Message Data ${data}');
        String isUserLogout = data['logout'];
        if (isUserLogout == '1') {
          // navigatorkey.currentContext!
          //     .read<AuthenticationController>()
          //     .logoutApi(navigatorkey.currentContext!);
          navigatorkey.currentContext!
              .read<AuthenticationController>()
              .updateIsLogout();
        }
      }
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.messageId,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
