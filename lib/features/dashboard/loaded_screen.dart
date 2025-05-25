import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';

class LoadedDashBoard extends StatelessWidget {
  const LoadedDashBoard({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColor.onprimarydark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                  Text(
                    'Dashboard',
                    style: GoogleFonts.sora(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              BlocBuilder<GetPredictionCubit, GetPredictionState>(
                builder: (context, getPredictionstate) {
                  return Container(
                    padding: EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      color:
                          (getPredictionstate as GottenPrediction)
                                      .prediction
                                      .status
                                      .toLowerCase() ==
                                  'unsafe'
                              ? AppColor.red.withOpacity(.8)
                              : AppColor.green.withOpacity(.8),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Center(
                      child: Text(
                        (getPredictionstate.prediction.status),
                        style: GoogleFonts.sora(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 30),
            child: BlocBuilder<GetSensorDataCubit, GetSensorDataState>(
              builder: (context, getSensorstate) {
                final value = (getSensorstate as GottenSensorData).sensorData;
                final dates = getDates(
                  timestamps: value.map((data) => data.timestamp).toList(),
                );
                return Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    //! PH
                    WaterQualityChart(
                      dates: dates,
                      isPH: true,
                      linecolor: AppColor.phcolor,
                      values: value.map((data) => data.pH).take(6).toList(),
                      parameterName: 'PH Level',
                      subText: 'Acidity / Alkalinity',
                      isHistogram: false,
                      parameterSI: '',
                    ),
                    //! TDS
                    WaterQualityChart(
                      dates: dates,
                      linecolor: AppColor.tdscolor,
                      values:
                          value
                              .map((data) => data.tds)
                              .take(20)
                              .toList(), // Example TDS values
                      parameterName: 'TDS (Total Dissolved Solids)',
                      subText: 'Dissolved particles concentration',
                      isHistogram: true,
                      parameterSI: 'ppm',
                    ),
                    //! TURBIDITY
                    WaterQualityChart(
                      dates: dates,
                      linecolor: AppColor.turbiditycolor,
                      values:
                          value
                              .map((data) => data.tub)
                              .take(14)
                              .toList(), // Example TDS values
                      parameterName: 'Turbidity',
                      subText: 'Water clarity level',
                      isHistogram: false,
                      parameterSI: 'NTU',
                    ),
                    //! TEMPERATURE
                    WaterQualityChart(
                      dates: dates,
                      linecolor: AppColor.temperaturecolor,
                      values:
                          value
                              .map((data) => data.temp)
                              .take(14)
                              .toList(), // Example TDS values
                      parameterName: 'Temperature',
                      subText: 'Water temperature',
                      isHistogram: true,
                      parameterSI: 'C',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
