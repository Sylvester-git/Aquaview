import 'package:waterapp/network/api.dart';

abstract class ApiDS {
  Future<List<Map<String, dynamic>>> getSensorData();
  Future<Map<String, dynamic>> getPrediction();
}

class ApiDsImpl implements ApiDS {
  final Api _api = Api();

  ApiDsImpl();
  @override
  Future<Map<String, dynamic>> getPrediction() async {
    try {
      final dio = await _api.getDio();
      final res = await dio.get('/api/predict');
      if (res.statusCode == 200 && (res.data as Map).isNotEmpty) {
        return (res.data as Map<String, dynamic>);
      } else {
        return {};
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSensorData() async {
    try {
      final dio = await _api.getDio();
      final res = await dio.get('/api/sensor_data');
      if (res.statusCode == 200 && (res.data as List).isNotEmpty) {
        return (res.data as List).cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
