part of 'get_sensor_data_cubit.dart';

abstract class GetSensorDataState extends Equatable {
  const GetSensorDataState();

  @override
  List<Object> get props => [];
}

class GetSensorDataInitial extends GetSensorDataState {}

class GettingSensorData extends GetSensorDataState {}

class ErrorGettingSensorData extends GetSensorDataState {
  final String errormessage;

  const ErrorGettingSensorData({required this.errormessage});
  @override
  List<Object> get props => [errormessage];
}

class GottenSensorData extends GetSensorDataState {
  final List<WQMSModel> sensorData;

  @override
  List<Object> get props => [sensorData];

  const GottenSensorData({required this.sensorData});
}
