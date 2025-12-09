import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/bank/data/services/bank_services.dart';
import 'package:pakkahishab/features/cash/data/services/cash_services.dart';


final bankRepositoryProvider = Provider<BankRepository>((ref) {
  final service = ref.read(bankServiceProvider);
  return BankRepository(service);
});

class BankRepository {
  final BankServices _bankServices;
  BankRepository(this._bankServices);

  Future<Map<String, dynamic>> getBankAmountItem({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _bankServices.getBankAmountItem(
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
    final response = await _bankServices.getStockProductName(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
