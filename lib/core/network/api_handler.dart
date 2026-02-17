import 'package:dio/dio.dart';

class ApiHandler {
  static Map<String, dynamic> handleResponse(Response response) {
    return {
      "success": true,
      "data": response.data,
      "statusCode": response.statusCode,
    };
  }

  static Map<String, dynamic> handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return _error("Connection timeout");
      case DioExceptionType.receiveTimeout:
        return _error("Receive timeout");
      case DioExceptionType.sendTimeout:
        return _error("Send timeout");
      case DioExceptionType.badResponse:
        return {
          "success": false,
          "statusCode": e.response?.statusCode,
          "message": e.response?.data ?? "Bad response",
        };
      default:
        return _error("Unexpected error: ${e.message}");
    }
  }

  static Map<String, dynamic> _error(String message) {
    return {"success": false, "statusCode": null, "message": message};
  }
}
