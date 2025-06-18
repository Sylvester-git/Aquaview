import 'package:intl/intl.dart';

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
  final DateFormat formatter = DateFormat('MMM d');
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

  return sortedDates.take(7).map((entry) => entry.key).toList();
}

String convertTimestamp({required String timestamps}) {
  final DateFormat dateFormat = DateFormat('MMMM d,').add_jm();
  final DateTime datatime = DateTime.parse(timestamps);
  return dateFormat.format(datatime);
}
