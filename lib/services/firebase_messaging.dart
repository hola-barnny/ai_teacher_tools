// lib/services/firebase_messaging.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // Initialize the notification service
  Future<void> init() async {
    // Initialize Flutter Local Notifications
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidSettings = AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permissions for iOS
    await _firebaseMessaging.requestPermission();

    // Get the FCM token (used for sending notifications)
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Set up a listener for incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message.notification!);
      }
    });
  }

  // Display a local notification
  Future<void> showNotification(RemoteNotification notification) async {
    var androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );
    var generalDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      generalDetails,
    );
  }

  // Handle background notifications (when app is closed)
  Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }
}
