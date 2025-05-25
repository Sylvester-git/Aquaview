import 'package:equatable/equatable.dart';

class WQMSModel extends Equatable {
  final String id;
  final String timestamp;
  final double pH;
  final double tds;
  final double temp;
  final double tub;

  const WQMSModel({
    required this.id,
    required this.timestamp,
    required this.pH,
    required this.tds,
    required this.temp,
    required this.tub,
  });

  @override
  List<Object?> get props => [id, timestamp, pH, tds, temp, tub];
}
