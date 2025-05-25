
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/functions.dart';

class WaterQualityChart extends StatelessWidget {
  const WaterQualityChart({
    super.key,
    required this.dates,
    required this.values,
    required this.parameterName,
    required this.subText,
    required this.isHistogram,
    required this.parameterSI,
  });

  final List<String> dates;
  final List<double> values;
  final String parameterName;
  final String subText;
  final bool isHistogram;
  final String parameterSI;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.tdscolor),
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? Title and subtitle
          Text(
            parameterName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subText,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: isHistogram ? _buildHistogram() : _buildLineChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    final minY = (values.reduce((a, b) => a < b ? a : b) - 0.5).floorToDouble();
    final maxY = (values.reduce((a, b) => a > b ? a : b) + 0.5).ceilToDouble();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= dates.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dates[value.toInt()],
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (dates.length - 1).toDouble(),
        minY: minY,

        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              values.length,
              (index) => FlSpot(index.toDouble(), values[index]),
            ),
            isCurved: true,
            color: const Color(0xFF4ECDC4),

            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(1)} PH Level',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHistogram() {
    // Group values into bins for histogram
    // const binSize = 60.0; // Adjust bin size as needed

    final minValue = (values.reduce((a, b) => a < b ? a : b)).floorToDouble();
    final maxValue = (values.reduce((a, b) => a > b ? a : b)).ceilToDouble();
    final minY =
        generateSteps(
          minValue,
          maxValue,
          steps: 5,
        ).reduce((a, b) => a < b ? a : b).toDouble() -
        minValue;
    final maxY =
        generateSteps(
          minValue,
          maxValue,
          steps: 5,
        ).reduce((a, b) => a > b ? a : b).toDouble() +
        minValue;
    final stepValues = generateSteps(minValue, maxValue, steps: 5);
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= dates.length) {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dates[value.toInt()],
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),

          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // if (value.toInt() >= dates.length) {
                //   return SizedBox.shrink();
                // }
                return Text(
                  'va',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minY: minY,
        maxY: maxY,
        barGroups: List.generate(values.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index].toDouble(),
                color: const Color(0xFF4ECDC4),
                width: 12,
                borderRadius: BorderRadius.zero,
              ),
            ],
          );
        }),
      ),
    );
  }
}
