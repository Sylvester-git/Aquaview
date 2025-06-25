import 'package:intl/intl.dart';
import 'package:waterapp/features/model/wqms.dart';

List<int> generateSteps(double minValue, double maxValue, {int steps = 10}) {
  if (minValue > maxValue) {
    double temp = minValue;
    minValue = maxValue;
    maxValue = temp;
  }

  List<int> results = [];
  double calculatedStepSize = (maxValue - minValue) / (steps - 1);
  for (int i = 0; i < steps; i++) {
    double value = minValue + (i * calculatedStepSize);
    results.add(int.parse(value.ceil().toString()));
  }

  return results;
}

List<String> getDates({required List<String> timestamps}) {
  final DateFormat formatter = DateFormat().add_jm();
  final List<MapEntry<DateTime, String>> dateTimePairs =
      timestamps.map((timestamp) {
        DateTime dateTime = DateTime.parse(timestamp);
        String formattedDate = formatter.format(dateTime);
        return MapEntry(dateTime, formattedDate);
      }).toList();

  final Map<String, DateTime> uniqueDateMap = {};
  for (var entry in dateTimePairs) {
    uniqueDateMap[entry.value] = entry.key;
  }

  final sortedDates =
      uniqueDateMap.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

  return sortedDates.take(6).map((entry) => entry.key).toList();
}

String convertTimestamp({required String timestamps}) {
  final DateFormat dateFormat = DateFormat('MMMM d,').add_jm();
  final DateTime datatime = DateTime.parse(timestamps);
  return dateFormat.format(datatime);
}

Map<String, List<WQMSModel>> groupByDay(List<WQMSModel> items) {
  final Map<String, List<WQMSModel>> grouped = {};

  for (final item in items) {
    final date = DateTime.parse(item.timestamp);
    final key =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    if (!grouped.containsKey(key)) {
      grouped[key] = [];
    }
    grouped[key]!.add(item);
  }

  return grouped;
}
