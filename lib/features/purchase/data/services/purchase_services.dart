import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:http/http.dart' as http;

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
          "godown_no": null,
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
    final body = {"products": products.map((e) => e.toJson()).toList()};

    final url =
        "${Urls.baseUrl}Insert_Pa_Product/?school_code=$code&MOBILE=$phone&PASSWORD=$pin";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      print("RAW RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print("DECODED DATA => $data");

        // ✅ CHECK STATUS
        if (data['status'] == 'success') {
          print("Product inserted successfully");

          return {'status': 'error', 'data': data}; // return full response
        } else {
          return {
            'status': 'error',
            'data': data['message'] ?? 'Unknown error',
          };
        }
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('UNKNOWN ERROR => $e');
      return {'status': 'error', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateProduct({
    required String code,
    required String phone,
    required String pin,
    required List<AddProductItem> products,
  }) async {
    final body = {"products": products.map((e) => e.toJson()).toList()};
    print(body);
    final url =
        "${Urls.baseUrl}update_pa_product/?school_code=$code&MOBILE=$phone&PASSWORD=$pin";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      print("RAW RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        print("DECODED DATA => $data");

        // ✅ CHECK STATUS
        if (data['status'] == 'success') {
          print("Product inserted successfully");

          return {'status': 'error', 'data': data}; // return full response
        } else {
          return {
            'status': 'error',
            'data': data['message'] ?? 'Unknown error',
          };
        }
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('UNKNOWN ERROR => $e');
      return {'status': 'error', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> addPurchase({
    String? purchaseDate,
    String? followUpDate,
    String? supplierId,

    String? netAmount,

    required String mobile,
    required String password,
    required String schoolCode,
    List<Map<String, dynamic>>? productList,
  }) async {
    final url = "${Urls.baseUrl}Insert_pa_purchase_and_p_details/";

    final dio = Dio();

    // Build query parameter map
    final queryParams = {
      "SCHOOL_CODE": schoolCode,
      "PASSWORD": password,
      "FOLLOW_UP_DATE": followUpDate,
      "MOBILE": mobile,
      "PURCHASE_DATE": purchaseDate,
      "SUPPLIER_ID": supplierId,
      "PURCHASE_TYPE": 0,
      "NET_AMOUNT": netAmount,
      "DUE": netAmount,
      "PAID_PRICE": 0.0,
    };

    // Remove null or empty values
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );
    print("query param $queryParams");

    final body = {"purchase_details": productList};

    print("body: $body");

    try {
      final response = await dio.post(
        url,
        data: body,
        queryParameters: queryParams,
      );
      print(response.data);

      if (response.statusCode == 200 && response.data['status'] == "success") {
        return {"statusCode": response.statusCode, "data": response.data};
      } else {
        return {"statusCode": response.statusCode, "data": response.data};
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return {"success": false, "message": "Connection timeout"};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {"success": false, "message": "Server took too long to respond"};
      } else if (e.type == DioExceptionType.badResponse) {
        return {
          "success": false,
          "message": "Server error: ${e.response?.statusCode}",
          "data": e.response?.data,
        };
      } else if (e.type == DioExceptionType.connectionError) {
        return {"success": false, "message": "No internet connection"};
      } else {
        return {"success": false, "message": "Unexpected error: ${e.message}"};
      }
    } catch (e) {
      return {"success": false, "message": "Unknown error: $e"};
    }
  }

  Future<Map<String, dynamic>> getPuchaseSupplierWise({
    required String phone,
    required String pin,
    required String offset,
    required String code,
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

      'supplier': supplierId,
    };
    print(supplierId);

    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}get_supplier_wise_total_purchase/";

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

  Future<Map<String, dynamic>> getPurchaseSupplierDues({
    required String phone,
    required String pin,

    required String code,

    required String supplierAccountNo,
  }) async {
    final Dio dio = Dio();
    print("Code: $code");
    print("Pin: $pin");
    print("Phone: $phone");
    // Base query parameters
    final Map<String, dynamic> queryParams = {
      'school_code': code,
      'mobile': phone,
      'password': pin,
      'offset': "0",
      'limit': '10',
      'ACCOUNT_NO': supplierAccountNo,
    };
    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}Get_PA_Supplier_due/";

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

  Future<Map<String, dynamic>> updateSupplier({
    required String phone,
    required String pin,
    required String code,
    required Map<String, dynamic> supplier,
  }) async {
    final url =
        "${Urls.baseUrl}Update_Supplier/?school_code=$code&MOBILE=$phone&PASSWORD=$pin";

    final body = {
      "suppliers": [supplier],
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body), // ✅ VERY IMPORTANT
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        return {'status': 'success', 'data': data};
      } else {
        return {'status': 'error', 'data': data};
      }
    } catch (e) {
      print("UPDATE SUPPLIER ERROR: $e");
      return {'status': "error", 'data': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deletePurchase({
    required String phone,
    required String pin,
    required String code,
    required String purchaseId,
  }) async {
    final String url =
        "${Urls.baseUrl}delete_purchase/?school_code=$code&mobile=$phone&password=$pin&purchase_id=$purchaseId";

    final Dio dio = Dio();
    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioException catch (e) {
      return {'statusCode': 666, 'data': e.response!.data};
    }
  }

  Future<Map<String, dynamic>> makePayment({
    required String phone,
    required String pin,
    required String schoolCode,
    required String supplierId,
    required double paid,
    required double due,
    required int paymentStatus,
    String? chequeNo,
    String? transactionId,
    String? paymentPhoneNo,
    String? followUpDate,

    required int accountNo,
    required String particulars,
  }) async {
    final String url =
        "${Urls.baseUrl}Supplier_due_payment/?MOBILE=$phone&SCHOOL_CODE=$schoolCode&PASSWORD=$pin";

    final Dio dio = Dio();

    final Map<String, dynamic> body = {
      "SUPPLIER_ID": supplierId,
      "PAID": paid,
      "DUE": due,
      "PAYMENT_STATUS": paymentStatus,
      "CHEQUE_NO": chequeNo,
      "TRANSECTION_ID": transactionId,
      "PAYMENT_PHONENO": paymentPhoneNo,
      "FOLLOW_UP_DATE": followUpDate, // yyyy-MM-dd
      "VOUCHER_DATE": formatDate(DateTime.now()), // yyyy-MM-dd
      "ACCOUNT_NO": accountNo,
      "PARTICULARS": particulars,
    };

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } catch (e) {
      print("Make Payment Error: $e");
      return {'statusCode': 666, 'data': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updatePurchase({
    required String purchaseId,
    required String mobile,
    required String password,
    required String schoolCode,
    List<Map<String, dynamic>>? productList,
  }) async {
    final url = "${Urls.baseUrl}update_purchase/"; // your update endpoint

    final dio = Dio();

    /// ✅ Query parameters
    final queryParams = {
      "SCHOOL_CODE": schoolCode,
      "PASSWORD": password,
      "MOBILE": mobile,
      "PURCHASE_ID": purchaseId,
    };

    /// Remove null / empty params
    queryParams.removeWhere(
      (key, value) => value.toString().isEmpty,
    );

    debugPrint("🔹 Update Purchase Query: $queryParams");

    /// ✅ Request body
    final body = {"purchase_details": productList};

    debugPrint("🔹 Update Purchase Body: $body");

    try {
      final response = await dio.post(
        url,
        queryParameters: queryParams,
        data: body,
      );

      debugPrint("🔹 Update Response: ${response.data}");

      if (response.statusCode == 200) {
        return {
          "success": true,
          "statusCode": response.statusCode,
          "data": response.data,
        };
      } else {
        return {
          "success": false,
          "statusCode": response.statusCode,
          "data": response.data,
        };
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return {"success": false, "message": "Connection timeout"};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {"success": false, "message": "Server took too long to respond"};
      } else if (e.type == DioExceptionType.badResponse) {
        return {
          "success": false,
          "message": "Server error: ${e.response?.statusCode}",
          "data": e.response?.data,
        };
      } else if (e.type == DioExceptionType.connectionError) {
        return {"success": false, "message": "No internet connection"};
      } else {
        return {"success": false, "message": "Unexpected error: ${e.message}"};
      }
    } catch (e) {
      return {"success": false, "message": "Unknown error: $e"};
    }
  }
}
