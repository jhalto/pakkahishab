import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';

final purchaseServiceProvider = Provider<PurchaseServices>(
  (ref) => PurchaseServices(),
);

class PurchaseServices {
  Future<Map<String, dynamic>> getPurchase({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? purchasedate,
    String? supplierId,
  }) async {
    final Dio dio = Dio();

    // Base query parameters
    final Map<String, dynamic> queryParams = {
      'school_code': code,
      'mobile': phone,
      'password': pin,
      'offset': offset,
      'limit': '10',
      'purchase_date': purchasedate,
      'supplier_id': supplierId,
    };
    print(supplierId);
    print(purchasedate);
    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}Get_Puchase/";

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

  Future<Map<String, dynamic>> getPurchaseDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String purchaseNo,
  }) async {
    final url =
        "${Urls.baseUrl}Get_Purchase_Details/?school_code=$code&password=$pin&mobile=$phone&purchase_no=$purchaseNo&offset=$offset&limit=10";

    final Dio dio = Dio();

    try {
      final response = await dio.get(url);

      print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }

  Future<Map<String, dynamic>> getSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}Supplier_name/?mobile=$phone&password=$pin&school_code=$code";
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

  Future<Map<String, dynamic>> getAllSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}all_supplier_name/?mobile=$phone&password=$pin&school_code=$code";
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      // print(url);
      // print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch Error $e"};
    }
  }

  Future<Map<String, dynamic>> addSupplier({
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
        "${Urls.baseUrl}Insert_Supplier/?school_code=$code&MOBILE=$mobile&PASSWORD=$pin";

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
        ),
      );
      print(response);
      // -------------------------
      // SUCCESS (status 200–299)
      // -------------------------

      return {
        "statusCode": response.statusCode,
        "success": true,
        "data": response.data,
      };
    } on DioException catch (e) {
      // -------------------------
      // DIO EXCEPTIONS (NETWORK ERRORS)
      // -------------------------

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return {
          "statusCode": e.response!.statusCode,
          "success": false,
          "message": "Connection timeout. Please try again.",
          "data": e.response?.data,
        };
      }

      if (e.type == DioExceptionType.badResponse) {
        return {
          "statusCode": e.response!.statusCode,
          "success": false,
          "message": "Server error occurred",
          "data": e.response?.data,
        };
      }

      if (e.type == DioExceptionType.connectionError) {
        return {
          "statusCode": e.response!.statusCode,
          "success": false,
          "message": "No internet connection",
        };
      }

      return {
        "statusCode": e.response!.statusCode,
        "success": false,
        "message": "Unexpected network error: ${e.message}",
      };
    } catch (e) {
      // -------------------------
      // ANY OTHER UNKNOWN ERRORS
      // -------------------------
      return {
        "statusCode": 666,
        "success": false,
        "message": "Unexpected error: $e",
      };
    }
  }

  Future<Map<String, dynamic>> getAllProduct({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}Get_PA_Product/?mobile=$phone&password=$pin&school_code=$code";
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      print(response);
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
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Connection timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.receiveTimeout:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Recieve timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.sendTimeout:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Send timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.badResponse:
          return {
            "success": false,
            "statusCode": e.response?.statusCode,
            "error": e.response?.data ?? "Bad Response",
          };
        case DioExceptionType.cancel:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Request cancel. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.unknown:
        default:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Unexpected network error: ${e.message}",
          };
      }
    } catch (e) {
      return {
        "statusCode": 666,
        "success": false,
        "message": "Unexpected error: $e",
      };
    }
  }

  Future<Map<String, dynamic>> addProduct({
    required String code,
    required String phone,
    required String pin,

    required List<AddProductItem> products,
  }) async {
    final body = {"products": products};

    final url =
        "${Urls.baseUrl}Insert_Pa_Product/?school_code=$code&MOBILE=$phone&PASSWORD=$pin";

    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      print(response);
      if (response.statusCode == 200) {
        return {"success": true, "data": response.data};
      } else {
        return {
          "success": false,
          "statusCode": response.statusCode,
          "message": "Unexpected status",
          "data": response.data,
        };
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Connection timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.receiveTimeout:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Recieve timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.sendTimeout:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Send timeout. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.badResponse:
          return {
            "success": false,
            "statusCode": e.response?.statusCode,
            "error": e.response?.data ?? "Bad Response",
          };
        case DioExceptionType.cancel:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Request cancel. Please try again.",
            "data": e.response?.data,
          };
        case DioExceptionType.unknown:
        default:
          return {
            "statusCode": e.response!.statusCode,
            "success": false,
            "message": "Unexpected network error: ${e.message}",
            "data": e.response?.data,
          };
      }
    } catch (e) {
      return {
        "statusCode": 666,
        "success": false,
        "message": "Unexpected error: $e",
      };
    }
  }
}
