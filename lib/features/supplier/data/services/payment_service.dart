import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) => PaymentService(),);


class PaymentService {
  Future<Map<String, dynamic>> getAllSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final url =
        "${Urls.baseUrl}all_supplier_name/?mobile=$phone&password=$pin&school_code=$code";
    final Dio dio = Dio();
    try {
      final response = await dio.get(url);
      // print(url);
      // print(response);
      return {"statusCode": response.statusCode, "data": response.data};
    } catch (e) {
      return {"statusCode": 666, "data": "Catch Error $e"};
    }
  }
}
