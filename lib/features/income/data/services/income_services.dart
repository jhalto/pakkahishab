import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final incomeServiceProvider = Provider<IncomeServices>(
  (ref) => IncomeServices(),
);

class IncomeServices {
  Future<Map<String, dynamic>> getIncomes({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? voucherdate,
    String? catagoryId,
  }) async {
    final Dio dio = Dio();

    // Base query parameters
    final Map<String, dynamic> queryParams = {
      'school_code': code,
      'mobile': phone,
      'password': pin,
      'offset': offset,
      'limit': '10',
      'CATEGORY': catagoryId,
      'voucher_date': voucherdate,
    };
   
    // ✅ Remove any null or empty parameters before request
    queryParams.removeWhere(
      (key, value) => value == null || value.toString().isEmpty,
    );

    final String url = "${Urls.baseUrl}Get_Income/";
  
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

  // Future<Map<String, dynamic>> getSaleDetails({
  //   required String phone,
  //   required String pin,
  //   required String offset,
  //   required String code,
  //   required String saleNo,
  // }) async {
  //   final url =
  //       "${Urls.baseUrl}Get_Sales_Details/?school_code=$code&password=$pin&mobile=$phone&sales_no=$saleNo&offset=$offset&limit=10";

  //   final Dio dio = Dio();

  //   try {
  //     final response = await dio.get(url);

  //     print(response);
  //     return {"statusCode": response.statusCode, "data": response.data};
  //   } catch (e) {
  //     return {"statusCode": 666, "data": "Catch error $e"};
  //   }
  // }

  Future<Map<String, dynamic>> getIncomeCatagory({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url = "${Urls.baseUrl}Get_Income_Head/?mobile=$phone&password=$pin&school_code=$code";
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
}
