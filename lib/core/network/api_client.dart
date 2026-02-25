import 'package:dio/dio.dart';
import 'package:pakkahishab/core/const/urls.dart';

class ApiClient {
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("REQUEST: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("RESPONSE: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;
}