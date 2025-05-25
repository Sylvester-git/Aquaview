part of 'get_prediction_cubit.dart';

abstract class GetPredictionState extends Equatable {
  const GetPredictionState();

  @override
  List<Object> get props => [];
}

class GetPredictionInitial extends GetPredictionState {}

class GettingPrediction extends GetPredictionState {}

class GottenPrediction extends GetPredictionState {
  final PredictionModel prediction;

  @override
  List<Object> get props => [prediction];

  const GottenPrediction({required this.prediction});
}

class ErrorGettingPrediction extends GetPredictionState {
  final String errormessage;
  @override
  List<Object> get props => [errormessage];

  const ErrorGettingPrediction({required this.errormessage});
}
