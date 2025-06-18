import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/features/cubit/get_alerts/get_alerts_cubit.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';

import '../cubit/login/login_cubit.dart';

class ApiCtrl {
  static Future<void> getSensorData({required BuildContext context}) =>
      context.read<GetSensorDataCubit>().loadSensorData();

  static Future<void> refreshSensorData({required BuildContext context}) =>
      context.read<GetSensorDataCubit>().refreshSensorData();

  static Future<void> getPrediction({required BuildContext context}) =>
      context.read<GetPredictionCubit>().getPrediction();

  static Future<void> refreshePrediction({required BuildContext context}) =>
      context.read<GetPredictionCubit>().refreshPrediction();

  static Future<void> login({required BuildContext context}) =>
      context.read<LoginCubit>().login();

  static Future<void> getAlerts({required BuildContext context}) =>
      context.read<GetAlertsCubit>().getAlerts();

  static Future<void> refreshAlerts({required BuildContext context}) =>
      context.read<GetAlertsCubit>().refreshAlerts();
}
