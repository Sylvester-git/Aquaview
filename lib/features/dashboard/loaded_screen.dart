import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';

class LoadedDashBoard extends StatelessWidget {
  const LoadedDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColor.phcolor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dashboard',
                style: GoogleFonts.sora(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              BlocBuilder<GetPredictionCubit, GetPredictionState>(
                builder: (context, getPredictionstate) {
                  return Container(decoration: BoxDecoration());
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
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
                      values: value.map((data) => data.pH).take(6).toList(),
                      parameterName: 'PH Level',
                      subText: 'Acidity / Alkalinity',
                      isHistogram: false,
                      parameterSI: '',
                    ),
                    //! TDS
                    WaterQualityChart(
                      dates: dates,
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
