import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

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
  queryParams.removeWhere((key, value) => value == null || value.toString().isEmpty);

  final String url = "${Urls.baseUrl}Get_Puchase/";

  try {
    final response = await dio.get(url, queryParameters: queryParams);

    print("Request URL: ${response.realUri}");
    print("Response: ${response.data}");

    return {
      "statusCode": response.statusCode,
      "data": response.data,
    };
  } on DioException catch (e) {
    return {
      "statusCode": e.response?.statusCode ?? 666,
      "data": e.response?.data ?? "Dio error: ${e.message}",
    };
  } catch (e) {
    return {
      "statusCode": 666,
      "data": "Unexpected error: $e",
    };
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
}
