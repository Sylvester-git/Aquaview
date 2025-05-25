import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/controllers/api_ctrl.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/dashboard/loaded_screen.dart';
import 'package:waterapp/features/widgets/scaffold_drawer.dart';
import 'package:waterapp/notification_helper.dart';
import 'package:waterapp/util/color.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  Timer? timer;
  @override
  void initState() {
    super.initState();

    getWQMSData();
    refreshWQMSData();
    PushNotificationHelper.initialize();
  }

  void getWQMSData() async {
    await Future.wait([
      ApiCtrl.getPrediction(context: context),
      ApiCtrl.getSensorData(context: context),
      ApiCtrl.login(context: context),
    ]);
  }

  void refreshWQMSData() {
    timer = Timer.periodic(const Duration(minutes: 2), (timer) async {
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
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
      key: _scaffoldKey,
      body: SafeArea(
        child:
            ((getPredictionCubit.state is GettingPrediction ||
                        getPredictionCubit.state is GetPredictionInitial) ||
                    (getSensorDataCubit.state is GettingSensorData ||
                        getSensorDataCubit.state is GetSensorDataInitial))
                ? Center(child: CircularProgressIndicator.adaptive())
                : (getPredictionCubit.state is ErrorGettingPrediction ||
                    getSensorDataCubit.state is ErrorGettingSensorData)
                ? Center(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'An error Occured ${(getPredictionCubit.state as ErrorGettingPrediction).errormessage}',
                        style: GoogleFonts.sora(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.phcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await Future.wait([
                              ApiCtrl.getPrediction(context: context),
                              ApiCtrl.getSensorData(context: context),
                            ]);
                          },
                          child: Center(
                            child: Text(
                              'Reload',
                              style: GoogleFonts.sora(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                : LoadedDashBoard(scaffoldKey: _scaffoldKey),
      ),
    );
  }
}
