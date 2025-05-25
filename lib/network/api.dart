import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:waterapp/config/config.dart';

class Api {
  late Dio dio;
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeout = 90;
    Map<String, dynamic> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "platform": Platform.isAndroid ? "android" : "ios",
      "language": "en",
    };
    dio.options = BaseOptions(
      connectTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
      headers: headers,
      baseUrl: ConfigServices.get('BASE_URL'),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
    return dio;
  }
}
