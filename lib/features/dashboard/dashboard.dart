import 'package:flutter/material.dart';
import 'package:waterapp/features/widgets/water_quality_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Icon(Icons.account_tree_sharp), Text('Dashboard')],
            ),
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
              'May 15',
            ],
            values: [7.7, 7.4, 7.8, 7.2, 7.6, 7.3, 7.5, 7.1],
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
              'May 15',
            ],
            values: [
              50,
              100,
              150,
              200,
              250,
              300,
              350,
              400,
            ], // Example TDS values
            parameterName: 'TDS (Total Dissolved Solids)',
            subText: 'Dissolved particles concentration',
            isHistogram: true,
            parameterSI: '',
          ),
        ],
      ),
    );
  }
}
