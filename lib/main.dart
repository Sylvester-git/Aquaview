import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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
      if (Firebase.apps.isEmpty) {
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      }
      Bloc.observer = MyBlocObserver();
      runApp(RootApp());
    },
    (error, stack) {
      runApp(ErrorScreen(erorrmessage: error.toString()));
    },
  );
}
