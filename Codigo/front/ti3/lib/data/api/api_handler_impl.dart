import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ti3/data/utils/exceptions/unknown_exception.dart';

import '../../domain/api/api_handler.dart';
import 'dio_client.dart';

class ApiHandlerImpl extends ApiHandler {
  final DioClient client;

  ApiHandlerImpl({
    required this.client,
  });

  @override
  void setJwt(String jwt) {
    client.setJwt(jwt);
  }

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await client.dio.get(
        path,
        queryParameters: queryParams,
      );

      logRequest(response);

      return response.data == "" ? "" : response.data;
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future<dynamic> post({
    required String path,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await client.dio.post(
        path,
        data: body,
        queryParameters: queryParams,
      );

      logRequest(response);

      return response.data;
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future patch({
    required String path,
    required body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await client.dio.patch(
        path,
        data: body,
        queryParameters: queryParams,
      );

      logRequest(response);

      return response.data;
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future delete({
    required String path,
    body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await client.dio.delete(
        path,
        data: body,
        queryParameters: queryParams,
      );

      logRequest(response);

      return response.data;
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Exception handleExceptions(Object error) {
    if (error is! DioException) return UnknownException();
    if (error.response == null) return UnknownException();
    logRequest(error.response!);
    return error;
  }

  void logRequest(Response<dynamic> response) {
    debugPrint(
      'ApiHandler | [${response.statusCode}] ${response.requestOptions.baseUrl + response.requestOptions.path}, statusMessage: ${response.statusMessage}, data: ${response.data}',
    );
  }

  void debugPrint(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }

}