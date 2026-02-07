

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/supplier/data/services/payment_service.dart';

final paymentRepositoriesProvider = Provider<PaymentRepositories>((ref) {
  final service = ref.read(paymentServiceProvider);
  return PaymentRepositories(service);
} );

class PaymentRepositories {
   final PaymentService _service;

   PaymentRepositories(this._service);
  Future<Map<String, dynamic>> getAllSupplier({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _service.getAllSupplier(
      phone: phone,
      pin: pin,
      code: code,
    );
    return response;
  }
}