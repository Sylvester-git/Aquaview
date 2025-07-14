import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:waterapp/config/config.dart';

class Api {
  late Dio dio;
  Future<Dio> getDio() async {
    Dio dio = Dio();
    dio.httpClientAdapter = BrowserHttpClientAdapter();

    int timeout = 120;
    Map<String, dynamic> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "language": "en",
    };
    dio.options = BaseOptions(
      connectTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
      headers: headers,
      baseUrl: ConfigServices.get('BASE_URL'),
    );
    dio.interceptors.add(PrettyDioLogger());
    return dio;
  }
}
