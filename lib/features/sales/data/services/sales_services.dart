import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final salesServiceProvider = Provider<SalesServices>((ref) => SalesServices());

class SalesServices {
  Future<Map<String, dynamic>> getSales({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? saledate,
    String? customerId,
  }) async {
    final Dio dio = Dio();

    // Base query parameters
    final Map<String, dynamic> queryParams = {
      'school_code': code,
      'mobile': phone,
      'password': pin,
      'offset': offset,
      'limit': '10',
      'SALES_DATE': saledate,
      'customer_id': customerId,
    };

    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}Get_sales/";

    try {
      final response = await dio.get(url, queryParameters: queryParams);

      print("Request URL: ${response.realUri}");
      print("Response: ${response.data}");

      return {"statusCode": response.statusCode, "data": response.data};
    } on DioException catch (e) {
      return {
        "statusCode": e.response?.statusCode ?? 666,
        "data": e.response?.data ?? "Dio error: ${e.message}",
      };
    } catch (e) {
      return {"statusCode": 666, "data": "Unexpected error: $e"};
    }
  }

  Future<Map<String, dynamic>> getSaleDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String saleNo,
  }) async {
    final url =
        "${Urls.baseUrl}Get_Sales_Details/?school_code=$code&password=$pin&mobile=$phone&sales_no=$saleNo&offset=$offset&limit=10";

    final Dio dio = Dio();

    try {
      final response = await dio.get(url);

      print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }

  Future<Map<String, dynamic>> getCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}Customer_name/?mobile=$phone&password=$pin&school_code=$code";
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      print(url);
      print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch Error $e"};
    }
  }

  Future<Map<String, dynamic>> addSales({
    required String phone,
    required String pin,
    required String schoolCode,
    required String customerId,
    required int salesType,
    required double netAmount,
    required double due,
    required double paidPrice,
    DateTime? date,
  }) async {
    final String url = "${Urls.baseUrl}Insert_sales_and_sales_details/";

    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    final DateTime finalDate = date ?? DateTime.now();
    final String formattedDate = finalDate.toIso8601String().split('T').first;

    final Map<String, dynamic> queryParams = {
      "SCHOOL_CODE": schoolCode,
      "PASSWORD": pin,
      "MOBILE": phone,
      "SALES_DATE": formattedDate,
      "CUSTOMER_ID": customerId,
      "SALES_TYPE": salesType,
      "NET_AMOUNT": netAmount,
      "DUE": due,
      "PAID_PRICE": paidPrice,
    };

    queryParams.removeWhere((key, value) => value is String && value.isEmpty);

    final body = {
      {
        "sales_details": [
          {"product_id": 25, "quantity": 5, "unit_price": 100},
          {"product_id": 26, "quantity": 3, "unit_price": 150},
          {"product_id": 24, "quantity": 10, "unit_price": 80},
        ],
      },
    };

    try {
      final response = await dio.get(url, queryParameters: queryParams);

      if (response.statusCode == 200) {
        return {"success": true, "data": response.data};
      } else {
        return {
          "success": false,
          "statusCode": response.statusCode,
          "message": "Unexpected status",
        };
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return {"success": false, "error": "Connection Timeout"};
        case DioExceptionType.receiveTimeout:
          return {"success": false, "error": "Receive Timeout"};
        case DioExceptionType.sendTimeout:
          return {"success": false, "error": "Send Timeout"};
        case DioExceptionType.badResponse:
          return {
            "success": false,
            "statusCode": e.response?.statusCode,
            "error": e.response?.data ?? "Bad Response",
          };
        case DioExceptionType.cancel:
          return {"success": false, "error": "Request Cancelled"};
        case DioExceptionType.unknown:
        default:
          return {"success": false, "error": "Unknown Error: ${e.message}"};
      }
    } catch (e) {
      return {"success": false, "error": "Unexpected Error: $e"};
    }
  }

  Future<Map<String, dynamic>> addCustomer({
    required String code,
    required String mobile,
    required String pin,
    required String customerName,
    required String customerPhone,
    String? customerAddress,
    String? customerEmail,
    int openingBalance = 0,
  }) async {
    final url =
        "${Urls.baseUrl}Insert_customer/?school_code=$code&MOBILE=$mobile&PASSWORD=$pin";

    final body = {
      "suppliers": [
        {
          "supplier_name": customerName,
          "phone": customerPhone,
          "address": customerAddress ?? "",
          "email": customerEmail ?? "",
          "godown_no": "1",
          "opening_balance": openingBalance,
        },
      ],
    };

    Dio dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10);

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {"Content-Type": "application/json"},
          // Validate only status code 200–299
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // -------------------------
      // SUCCESS (status 200–299)
      // -------------------------
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return {"success": true, "data": response.data};
      }

      // -------------------------
      // API Returned Error (400–499)
      // -------------------------
      return {
        "success": false,
        "message": "API returned an error",
        "statusCode": response.statusCode,
        "data": response.data,
      };
    } on DioException catch (e) {
      // -------------------------
      // DIO EXCEPTIONS (NETWORK ERRORS)
      // -------------------------

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return {
          "success": false,
          "message": "Connection timeout. Please try again.",
        };
      }

      if (e.type == DioExceptionType.badResponse) {
        return {
          "success": false,
          "message": "Server error occurred",
          "statusCode": e.response?.statusCode,
          "data": e.response?.data,
        };
      }

      if (e.type == DioExceptionType.connectionError) {
        return {"success": false, "message": "No internet connection"};
      }

      return {
        "success": false,
        "message": "Unexpected network error: ${e.message}",
      };
    } catch (e) {
      // -------------------------
      // ANY OTHER UNKNOWN ERRORS
      // -------------------------
      return {"success": false, "message": "Unexpected error: $e"};
    }
  }
}
