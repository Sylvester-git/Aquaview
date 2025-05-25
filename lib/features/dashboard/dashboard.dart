import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/controllers/api_ctrl.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/dashboard/loaded_screen.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    getWQMSData();
    refreshWQMSData();
  }

  void getWQMSData() async {
    await Future.wait([
      ApiCtrl.getPrediction(context: context),
      ApiCtrl.getSensorData(context: context),
    ]);
  }

  void refreshWQMSData() {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await Future.wait([
        ApiCtrl.refreshSensorData(context: context),
        ApiCtrl.refreshePrediction(context: context),
      ]);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getSensorDataCubit = context.watch<GetSensorDataCubit>();
    final getPredictionCubit = context.watch<GetPredictionCubit>();
    return Scaffold(
      body: SafeArea(
        child:
            (getPredictionCubit.state is GettingPrediction ||
                    getSensorDataCubit.state is GettingSensorData)
                ? Center(child: CircularProgressIndicator.adaptive())
                : LoadedDashBoard(),
      ),
    );
  }
}
