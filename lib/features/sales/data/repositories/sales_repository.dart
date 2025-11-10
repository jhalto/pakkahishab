import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/sales/data/services/sales_services.dart';

final salesRepositoryProvider = Provider<SalesRepository>((ref) {
  final service = ref.read(salesServiceProvider);
  return SalesRepository(service);
});

class SalesRepository {
  final SalesServices _salesServices;
  SalesRepository(this._salesServices);

  Future<Map<String, dynamic>> getSales({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    String? saleDate,
    String? customerId,
  }) async {
    final purchaseData = await _salesServices.getSales(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
      saledate: saleDate,
      customerId: customerId,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getSaleDetails({
    required String phone,
    required String pin,
    required String offset,
    required String code,
    required String saleNo,
  }) async {
    final purchaseData = await _salesServices.getSaleDetails(
      saleNo: saleNo,
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  Future<Map<String, dynamic>> getCustomer({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _salesServices.getCustomer(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
