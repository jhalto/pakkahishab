import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final customerDueServiceProvider = Provider.autoDispose<CustomerDueServices>(
  (ref) => CustomerDueServices(),
);

class CustomerDueServices {
  Future<Map<String, dynamic>> getCustomerDues({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? dueDate,
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
      'voucher_date': dueDate,
      'ACCOUNT_NO': customerId,
    };
    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}Get_PA_Customer_Due/";

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

  Future<Map<String, dynamic>> getCustomerDueDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String customerId,
  }) async {
    final url =
        "${Urls.baseUrl}Get_PA_Customer_due_details/?school_code=$code&password=$pin&mobile=$phone&password=$pin&offset=$offset&limit=10&CUSTOMER=$customerId";

    final Dio dio = Dio();

    try {
      final response = await dio.get(url);

      print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }

  Future<Map<String, dynamic>> getDueCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}Get_Accountname_Customer/?school_code=$code&mobile=$phone&password=$pin";
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      print("due Customer");
      print(url);
      if (kDebugMode) {
        print(response);
      }
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch Error $e"};
    }
  }

  Future<Map<String, dynamic>> getCustomerSales({
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
      'customer_id': customerId,
    };
    print(customerId);
    print(saledate);
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

  Future<Map<String, dynamic>> getCustomerSaleDetails({
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
}
