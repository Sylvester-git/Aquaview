import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:waterapp/network/api_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiRepo _apiRepo;
  LoginCubit(this._apiRepo) : super(LoginInitial());

  Future<void> login() async {
    final fcmtoken = await FirebaseMessaging.instance.getToken();
    if (fcmtoken != null) {
      final res = await _apiRepo.login(fcmtoken: fcmtoken);
      res.fold(
        (l) {
          log(l.message);
        },
        (r) {
          emit(LoggedIn());
        },
      );
    }
  }
}
