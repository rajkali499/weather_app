import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/api_response.dart';

enum HttpMethod { get, post, put, delete }

class ApiClient {

  static final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<ApiResponse<T>> callApi<T>({
    required String endpoint,
    required HttpMethod method,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse(
      endpoint,
    ).replace(queryParameters: queryParams);

    try {
      late http.Response response;

      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: _defaultHeaders);
          break;
        case HttpMethod.post:
          response = await http.post(
            uri,
            headers: _defaultHeaders,
            body: jsonEncode(body ?? {}),
          );
          break;
        case HttpMethod.put:
          response = await http.put(
            uri,
            headers: _defaultHeaders,
            body: jsonEncode(body ?? {}),
          );
          break;
        case HttpMethod.delete:
          response = await http.delete(uri, headers: _defaultHeaders);
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final parsedData = fromJson(json);
        return ApiResponse<T>(success: true, data: parsedData);
      } else {
        return ApiResponse<T>(
          success: false,
          message: 'Error ${response.statusCode} something went wrong',
        );
      }
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'Error $e something went wrong',
      );
    }
  }
}
