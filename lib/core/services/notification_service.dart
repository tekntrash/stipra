import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stipra/core/utils/router/app_router.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../domain/repositories/data_repository.dart';

class NotificationService {
  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin fltNotification;
  String? token;

  Future<void> init() async {
    _initMessager();
    await _requestPermission();
    await _initMessaging();
    _getToken();
    _startTokenChangeListener();
  }

  void _initMessager() {
    messaging = FirebaseMessaging.instance;
  }

  Future<void> _initMessaging() async {
    var androiInit = AndroidInitializationSettings('ic_logo');

    var iosInit = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    await fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        channelName: message.data["category"],
        channelDesc: message.data["desc"],
      );
    });
  }

  void _getToken() async {
    token = await messaging.getToken();
    if (token == null) {
      await Future.delayed(Duration(seconds: 1)).then((value) => _getToken());
    } else {
      log('My token: $token');
      log('My token2: ${locator<NotificationService>().token}');
      locator<DataRepository>().saveFCMToken(token ?? '');
      //await Future.delayed(Duration(seconds: 1));
      /*WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        showDialog(
          context: AppRouter().mainNavigatorKey!.currentState!.context,
          builder: (context) => Center(
            child: Container(
              width: 1.sw,
              height: 100,
              child: Material(
                child: TextField(
                  controller: TextEditingController(text: token),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Token',
                  ),
                  readOnly: true,
                ),
              ),
            ),
          ),
        );
      });*/
      //_showNotificationCustomVibrationIconLed();
    }
  }

  Future<void> _showNotificationCustomVibrationIconLed() async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'other custom channel id', 'other custom channel name',
            channelDescription: 'other custom channel description',
            icon: 'ic_logo',
            largeIcon: const DrawableResourceAndroidBitmap('ic_logo'),
            enableLights: true,
            ledColor: const Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500);
    final IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(
      subtitle: 'Hello',
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fltNotification.show(
        0,
        'title of notification with custom vibration pattern, LED and icon',
        'body of notification with custom vibration pattern, LED and icon',
        platformChannelSpecifics);
  }

  void _startTokenChangeListener() {
    @override
    Stream<String> fcmStream = messaging.onTokenRefresh;
    fcmStream.listen((newToken) {
      log('My token: $token');
      token = newToken;
      sendTokenToServer();
    });
  }

  void _showNotification({
    required String? title,
    required String? body,
    required String? channelName,
    required String? channelDesc,
  }) async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      channelName ?? 'Stipra',
      channelDescription: channelDesc,
      importance: Importance.max,
      priority: Priority.high,

      //category: "Kategoriisii",
      color: AppTheme().blackColor,
      channelShowBadge: true,
      //subText: 'hello',
      colorized: false,
      /*ledColor: Colors.red,
      ledOnMs: 100,
      ledOffMs: 100,*/
      //largeIcon: DrawableResourceAndroidBitmap('ic_notification.png'),
    );

    var iosDetails = IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    if (channelName == 'Sohbet') {
      return;
    }

    await fltNotification.show(0, title ?? "Stipra",
        body ?? "You have a notification.", generalNotificationDetails,
        payload: 'Notification');
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: AppRouter().mainNavigatorKey!.currentState!.context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? 'Stipra'),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> sendTokenToServer() async {
    /*NetworkService().sendMessage(
      json.encode({"msgType": "userSetToken", "token": token}),
    );*/
  }
}
