
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
  }) async {
    final url =
        "${Urls.baseUrl}Get_Puchase/?school_code=$code&mobile=$phone&password=$pin&offset=$offset&limit=10";

    final Dio dio = Dio();

    try {
      final response = await dio.get(url);
       print(url);
       print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }
}
