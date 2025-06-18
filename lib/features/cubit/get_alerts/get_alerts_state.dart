part of 'get_alerts_cubit.dart';

sealed class GetAlertsState extends Equatable {
  const GetAlertsState();

  @override
  List<Object> get props => [];
}

final class GetAlertsInitial extends GetAlertsState {}

final class GettingAlerts extends GetAlertsState {}

final class ErrorGettingAlerts extends GetAlertsState {
  final String errormessage;

  const ErrorGettingAlerts({required this.errormessage});
  @override
  List<Object> get props => [errormessage];
}

class GottenAlerts extends GetAlertsState {
  final List<Alerts> alerts;

  const GottenAlerts({required this.alerts});
  @override
  List<Object> get props => [alerts];
}
