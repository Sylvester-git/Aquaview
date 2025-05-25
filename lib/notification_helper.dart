import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  log("BackgroundHandler: ");
  log(message.data.toString());
  log(message.notification?.title ?? "");
  NotificationHelper.displayNotification(message);
}

class PushNotificationHelper {
  static Future<void> initialize() async {
    NotificationHelper.initialize();

    final hasNotificationPermission = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          badge: true,
          criticalAlert: true,
          sound: true,
        );

    if (hasNotificationPermission.authorizationStatus ==
            AuthorizationStatus.denied ||
        hasNotificationPermission.authorizationStatus ==
            AuthorizationStatus.notDetermined) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        criticalAlert: true,
        sound: true,
      );
    }

    if (hasNotificationPermission.authorizationStatus ==
        AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      //! If app is terminated state and used click notification
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          log('New notification');
          log(message.data.toString());
          log(message.notification?.title ?? "");
        }
      });
      //! App is in forground
      FirebaseMessaging.onMessage.listen((message) {
        log('FirebaseMessaging listening');
        if (message.notification != null) {
          log(message.notification!.title.toString());
          log(message.notification!.body.toString());
          log(message.data.toString());

          if (Platform.isAndroid) {
            //! Local notification code to displat alert
            NotificationHelper.displayNotification(message);
          }
        }
      });
      //! App on Background not Terminated
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        log('Firebasemessaging onMessaging Message opened');
        if (message.notification != null) {
          log(message.notification!.title.toString());
          log(message.notification!.body.toString());
          log(message.data.toString());

          //! Open Notification
          openNotification(message.data);
        }
      });
    }
  }
}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel androidchannel =
      AndroidNotificationChannel(
        '@Kaysavo_by_Graycrest23',
        'Notification',
        playSound: true,
        importance: Importance.high,
        showBadge: true,
      );

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsiOS =
        DarwinInitializationSettings();

    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()!
          .requestNotificationsPermission();
    }
    if (Platform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(androidchannel);
    }
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsiOS,
      ),
      onDidReceiveNotificationResponse: (details) {},
      onDidReceiveBackgroundNotificationResponse: localBackgroundHandler,
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          '@Kaysavo_by_Graycrest23',
          'Notification',
          importance: Importance.high,
          priority: Priority.high,
          channelShowBadge: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

Future<void> localBackgroundHandler(NotificationResponse data) async {
  try {
    var payloadObj = json.decode(data.payload ?? "{}") as Map? ?? {};
    openNotification(payloadObj);
  } catch (e) {
    log(e.toString());
  }
}

void openNotification(Map payloadObj) async {
  log(payloadObj.toString());
}

void openNotificationScreen(Map payloadObj) {
  log(payloadObj.toString());
}
