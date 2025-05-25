import 'package:equatable/equatable.dart';

class PredictionModel extends Equatable {
  final String timestamp;
  final double pH;
  final double tds;
  final double temp;
  final double tub;
  final double confidence;
  final String status;

  const PredictionModel({
    required this.timestamp,
    required this.pH,
    required this.tds,
    required this.temp,
    required this.tub,
    required this.confidence,
    required this.status,
  });

  @override
  List<Object?> get props => [
    timestamp,
    pH,
    tds,
    temp,
    tub,
    confidence,
    status,
  ];
}
