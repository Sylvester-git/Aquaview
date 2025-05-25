import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';

import '../../cubit/get_sensor_data/get_sensor_data_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
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
    );
  }
}
