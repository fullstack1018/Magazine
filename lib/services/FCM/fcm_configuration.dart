// ignore_for_file: require_trailing_commas, unnecessary_null_comparison, unused_field, unused_local_variable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magazine/services/notification/notifications_services.dart';
import 'package:magazine/utils/constants/constant_strings.dart';
import 'package:magazine/utils/widgets/app_text.dart';

class TokenMonitor extends StatefulWidget {
  TokenMonitor(this._builder);
  final Widget Function(String? token) _builder;
  @override
  State<StatefulWidget> createState() => _TokenMonitor();
}

class _TokenMonitor extends State<TokenMonitor> with WidgetsBindingObserver {
  String? _token;
  late Stream<String> _tokenStream;
  void setToken(String? token) {
    print('FCM Token: $token');
    setState(() {
      _token = token;
      ApiConstant.FCM_TOKEN = token!;
    });
  }

  AppLifecycleState? _notification;
  getFCMToken() {
    FirebaseMessaging.instance
        .getToken(
            vapidKey:
                'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  @override
  void initState() {
    NotificationService().clearAllNotifications();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getFCMToken();
    initialShipperNotification();
    notificationHandling();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_token);
  }
}

bool isConfigured = false;

initialShipperNotification() {
  if (!isConfigured) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {}
    });
    isConfigured = true;
  }
}

notificationHandling() {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true, alert: true, sound: true);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    printLog("Notifications onMessage: ${message.data}");
    showFlutterNotification(message: message, paylod: "paylod");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    printLog("Notifications onMessageOpenedApp: ${message.data}");

    if (message != null) {}
    // showFlutterNotification(message: message, paylod: "paylod");
  });
}

Future<void> setupFlutterNotifications() async {
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void showFlutterNotification(
    {required RemoteMessage message, required String paylod}) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    NotificationService().showNotifications(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: paylod);
  }
}
