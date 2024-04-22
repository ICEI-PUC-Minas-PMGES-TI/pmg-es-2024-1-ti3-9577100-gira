import 'package:dio/dio.dart';
import 'package:ti3/shared/statics/endpoints.dart';

class DioClient {
  late Dio dio;

  final String baseUrl = Endpoints.baseUrl;
  final connectTimeout = const Duration(seconds: 30);

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: _getHeaders(),
        connectTimeout: connectTimeout,
      ),
    );
  }

  Map<String, String> _getHeaders() {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  void setJwt(String jwt) {
    var headers = dio.options.headers;
    headers['Authorization'] = 'Bearer $jwt';
    dio.options.headers = headers;
  }
}