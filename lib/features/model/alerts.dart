import 'package:equatable/equatable.dart';

class Alerts extends Equatable {
  final String id;
  final String timestamp;
  final List alerts;

  const Alerts({
    required this.id,
    required this.timestamp,
    required this.alerts,
  });
  @override
  List<Object?> get props => [id, timestamp, alerts];
}
