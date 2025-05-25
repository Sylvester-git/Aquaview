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
