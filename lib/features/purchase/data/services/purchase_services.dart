import 'dart:math';

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
  }) async {
    final url =
        "${Urls.baseUrl}Get_Puchase/?school_code=1&mobile=$phone&password=$pin&offset=$offset&limit=10";

    Dio dio = Dio();

    try {
      final response = await dio.get(url);

      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch error $e"};
    }
  }
}
