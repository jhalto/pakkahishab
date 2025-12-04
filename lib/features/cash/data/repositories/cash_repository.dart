import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/cash/data/services/cash_services.dart';


final cashRepositoryProvider = Provider<CashRepository>((ref) {
  final service = ref.read(cashServiceProvider);
  return CashRepository(service);
});

class CashRepository {
  final CashServices _stockServices;
  CashRepository(this._stockServices);

  Future<Map<String, dynamic>> getCash({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _stockServices.getCash(
      phone: phone,
      pin: pin,
      offset: offset,
      code: code,
    );
    print(purchaseData.length);
    return purchaseData;
  }

  // Future<Map<String, dynamic>> getSaleDetails({
  //   required String phone,
  //   required String pin,
  //   required String offset,
  //   required String code,
  //   required String saleNo,
  // }) async {
  //   final purchaseData = await _incomeServices.getSaleDetails(
  //     saleNo: saleNo,
  //     phone: phone,
  //     pin: pin,
  //     offset: offset,
  //     code: code,
  //   );
  //   print(purchaseData.length);
  //   return purchaseData;
  // }

  Future<Map<String, dynamic>> getStockProductName({
    required String phone,
    required String pin,
    required String code,
  }) async {
    final response = await _stockServices.getStockProductName(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
