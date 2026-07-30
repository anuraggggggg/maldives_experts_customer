import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService({FirebaseMessaging? messaging})
    : _messaging = messaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _messaging;

  Future<NotificationSettings> requestPermission() =>
      _messaging.requestPermission();
}
