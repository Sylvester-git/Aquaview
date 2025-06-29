import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';
import 'package:waterapp/util/mapper.dart';

import '../../cubit/get_sensor_data/get_sensor_data_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final predictionCubit = context.watch<GetPredictionCubit>().state;
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 30),
        child: BlocBuilder<GetSensorDataCubit, GetSensorDataState>(
          builder: (context, getSensorstate) {
            final value =
                (getSensorstate as GottenSensorData).sensorData
                    .where(
                      (data) =>
                          ((data.timestamp.convertToDateTime().day ==
                                  DateTime.now().day) &&
                              data.timestamp.convertToDateTime().month ==
                                  DateTime.now().month),
                    )
                    .take(6)
                    .toList();
            final dates = getDates(
              timestamps:
                  value
                      .where(
                        (data) =>
                            ((data.timestamp.convertToDateTime().day ==
                                    DateTime.now().day) &&
                                data.timestamp.convertToDateTime().month ==
                                    DateTime.now().month),
                      )
                      .map((data) => data.timestamp)
                      .take(6)
                      .toList(),
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
                  currentReading:
                      predictionCubit is! GottenPrediction
                          ? 0.0
                          : (predictionCubit.prediction.pH),
                  linecolor: AppColor.phcolor,
                  values:
                      value
                          .map((data) => data.pH)
                          .take(6)
                          .toList()
                          .reversed
                          .toList(),
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
                          .take(6)
                          .toList()
                          .reversed
                          .toList(), // Example TDS values
                  currentReading:
                      predictionCubit is! GottenPrediction
                          ? 0.0
                          : (predictionCubit.prediction.tds),
                  parameterName: 'TDS',
                  subText: 'Total Dissolved Solids',
                  isHistogram: false,
                  parameterSI: 'ppm',
                ),
                //! TURBIDITY
                WaterQualityChart(
                  dates: dates,
                  linecolor: AppColor.turbiditycolor,
                  values:
                      value
                          .map((data) => data.tub)
                          .take(6)
                          .toList()
                          .reversed
                          .toList(), // Example TDS values
                  parameterName: 'Turbidity',
                  subText: 'Water clarity level',
                  currentReading:
                      predictionCubit is! GottenPrediction
                          ? 0.0
                          : (predictionCubit.prediction.tub),
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
                          .take(6)
                          .toList()
                          .reversed
                          .toList(), // Example TDS values
                  currentReading:
                      predictionCubit is! GottenPrediction
                          ? 0.0
                          : (predictionCubit.prediction.temp),
                  parameterName: 'Temperature',
                  subText: 'Water temperature',
                  isHistogram: false,
                  parameterSI: 'C',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
