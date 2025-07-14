import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waterapp/app/app.dart';
import 'package:waterapp/app/bloc_obserever.dart';
import 'package:waterapp/app/error_screen.dart';
import 'package:waterapp/app/init.dart';
import 'package:waterapp/config/config.dart';
import 'package:waterapp/config/firebase_config.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppInitializer.preRun();
      await ConfigServices.loadConfig();
      log(ConfigServices.isLoaded.toString());
      if (!kIsWeb) {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }
      } else {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      Bloc.observer = MyBlocObserver();
      runnAppOnPlatform();
    },
    (error, stack) {
      log(stack.toString());
      log(error.toString());
    },
  );
}

void runnAppOnPlatform() {
  if (kIsWeb) {
    runApp(
      DevicePreview(
        backgroundColor: Colors.white,
        enabled: true,
        defaultDevice: Devices.ios.iPhone13ProMax,
        isToolbarVisible: true,
        availableLocales: const [Locale('en', 'US')],
        tools: const [
          DeviceSection(
            model: true,
            orientation: false,
            frameVisibility: false,
            virtualKeyboard: false,
          ),
        ],
        devices: [...Devices.all],
        builder: (context) {
          return RootApp();
        },
      ),
    );
  } else {
    runApp(RootApp());
  }
}
