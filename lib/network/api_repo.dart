import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:waterapp/features/model/alerts.dart';
import 'package:waterapp/features/model/prediction.dart';
import 'package:waterapp/features/model/wqms.dart';
import 'package:waterapp/network/api_ds.dart';
import 'package:waterapp/network/fail.dart';
import 'package:waterapp/util/mapper.dart';

abstract class ApiRepo {
  Future<Either<Failure, List<WQMSModel>>> getSensorData();
  Future<Either<Failure, PredictionModel>> getPrediction();
  Future<Either<Failure, List<Alerts>>> getAlerts();
  Future<Either<Failure, bool>> login({required String fcmtoken});
}

class ApiRepoImpl implements ApiRepo {
  final ApiDS _apiDS;

  ApiRepoImpl({required ApiDS apiDS}) : _apiDS = apiDS;
  @override
  Future<Either<Failure, PredictionModel>> getPrediction() async {
    try {
      final res = await _apiDS.getPrediction();
      if (res.isNotEmpty) {
        final value = res.convertToPredictionModel();
        return right(value);
      } else {
        return left(Failure(message: ""));
      }
    } on DioException catch (e) {
      return left(Failure(message: e.message ?? ""));
    }
  }

  @override
  Future<Either<Failure, List<WQMSModel>>> getSensorData() async {
    try {
      final res = await _apiDS.getSensorData();
      final val = res.map((data) => data.convertToWQMSModel()).toList();
      return right(val);
    } on DioException catch (e) {
      return left(Failure(message: e.message ?? ""));
    }
  }

  @override
  Future<Either<Failure, bool>> login({required String fcmtoken}) async {
    try {
      final res = await _apiDS.login(fcmtoken: fcmtoken);
      return right(res);
    } on DioException catch (e) {
      return left(Failure(message: e.message ?? ""));
    }
  }

  @override
  Future<Either<Failure, List<Alerts>>> getAlerts() async {
    try {
      final res = await _apiDS.getAlerts();
      final val = res.map((data) => data.convertToAlertsModel()).toList();
      return right(val);
    } on DioException catch (e) {
      return left(Failure(message: e.message ?? ""));
    }
  }
}
