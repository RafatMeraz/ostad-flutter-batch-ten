import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );

    // foreground
    FirebaseMessaging.onMessage.listen(_handleNotification);

    // background/hide/minimize
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

    // terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }

  void _handleNotification(RemoteMessage message) {
    print(message.notification?.title);
    print(message.notification?.body);
    print(message.data);
  }

  Future<String?> getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  Future<void> onTokenRefresh() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((String? newToken) {
      print('Sending to server');
    });
  }
}

Future<void> handleBackgroundNotification(RemoteMessage message) async {
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);
}
