import 'package:bloc/bloc.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      log(event.toString(), name: "On_Event");
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log(error.toString(), name: "On_Error");
      log(stackTrace.toString(), name: "On_Error_StackTrace");
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log(change.toString(), name: "On_Changed");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      log(transition.toString(), name: "On_Transition");
    }
  }
}
