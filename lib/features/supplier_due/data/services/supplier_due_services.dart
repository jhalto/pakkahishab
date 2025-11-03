import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final supplierDueServiceProvider = Provider<SupplierDueServices>(
  (ref) => SupplierDueServices(),
);

class SupplierDueServices {
  Future<Map<String, dynamic>> getSupplierDues({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? dueDate,
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
      'voucher_date': dueDate,
      'supplier_id': supplierId,
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

  Future<Map<String, dynamic>> getSupplierDueDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String purchaseNo,
  }) async {
    final url =
        "${Urls.baseUrl}Get_PA_Supplier_due_details/?school_code=$code&password=$pin&mobile=$phone&purchase_no=$purchaseNo&offset=$offset&limit=10";

    final Dio dio = Dio();

    try {
      final response = await dio.get(url);

      print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }

  Future<Map<String, dynamic>> getDueSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {

    final url =
        "${Urls.baseUrl}Get_AccountName_Supplier/?school_code=$code&mobile=$phone&password=$pin";
    Dio dio = Dio();
    try {
      final response = await dio.get(url);
      print("due supplier");
      print(url);
      if (kDebugMode) {
        print(response);
      }
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch Error $e"};
    }
  }
}
