import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/app/dependency_inj.dart';
import 'package:waterapp/features/cubit/current_page/current_page_cubit.dart';
import 'package:waterapp/features/cubit/get_alerts/get_alerts_cubit.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/cubit/login/login_cubit.dart';

MultiBlocProvider getProvider({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => instance<GetSensorDataCubit>()),
      BlocProvider(create: (context) => instance<GetPredictionCubit>()),
      BlocProvider(create: (context) => instance<LoginCubit>()),
      BlocProvider(create: (context) => instance<CurrentPageCubit>()),
      BlocProvider(create: (context) => instance<GetAlertsCubit>()),
    ],
    child: child,
  );
}
