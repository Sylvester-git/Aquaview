import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    WaterQualityChart(
                      dates: [
                        'Apr 16',
                        'Apr 20',
                        'Apr 24',
                        'Apr 28',
                        'May 2',
                        'May 6',
                        'May 10',
                      ],
                      values: [6.7, 7.4, 6.0, 12.3, 7.0, 7.5, 6.5],
                      parameterName: 'PH Level',
                      subText: 'Acidity / Alkalinity',
                      isHistogram: false,
                      parameterSI: '',
                    ),
                    WaterQualityChart(
                      dates: [
                        'Apr 16',
                        'Apr 20',
                        'Apr 24',
                        'Apr 28',
                        'May 2',
                        'May 6',
                        'May 10',
                      ],
                      values: [
                        100,
                        200,
                        50,
                        75,
                        350,
                        125,
                        50,
                        65,
                        39,
                        40,
                        50,
                        30,
                        50,
                        100,
                        40,
                        50,
                        20,
                        94,
                        29,
                        30,
                      ], // Example TDS values
                      parameterName: 'TDS (Total Dissolved Solids)',
                      subText: 'Dissolved particles concentration',
                      isHistogram: true,
                      parameterSI: '',
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
