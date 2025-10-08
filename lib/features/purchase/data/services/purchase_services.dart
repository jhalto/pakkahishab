
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
  String purchasedate = '',
  String supplierId = '',
}) async {
  final Dio dio = Dio();

  // Build query parameters dynamically
  final Map<String, dynamic> queryParams = {
    'school_code': code,
    'mobile': phone,
    'password': pin,
    'offset': offset,
    'limit': '10',
  };

  // Include optional parameters only if they are not empty
  if (purchasedate.isNotEmpty) queryParams['purchase_date'] = purchasedate;
  if (supplierId.isNotEmpty) queryParams['supplier_id'] = supplierId;

  final String url = "${Urls.baseUrl}Get_Puchase/";

  try {
    final response = await dio.get(url, queryParameters: queryParams);

    // Optional: print actual URL and response
    print("Request URL: ${response.realUri}");
    print("Response: ${response.data}");

    return {
      "statusCode": response.statusCode,
      "data": response.data,
    };
  } on DioException catch (e) {
    // Handle Dio-specific errors
    return {
      "statusCode": e.response?.statusCode ?? 666,
      "data": e.response?.data ?? "Dio error: ${e.message}"
    };
  } catch (e) {
    // Handle unexpected errors
    return {
      "statusCode": 666,
      "data": "Unexpected error: $e"
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
