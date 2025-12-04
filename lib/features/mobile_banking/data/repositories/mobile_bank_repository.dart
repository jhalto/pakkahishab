import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/mobile_banking/data/services/mobile_bank_services.dart';



final mobileBankRepositoryProvider = Provider<MobileBankRepository>((ref) {
  final service = ref.read(mobileBankServiceProvider);
  return MobileBankRepository(service);
});

class MobileBankRepository {
  final MobileBankServices _mobileBankServices;
  MobileBankRepository(this._mobileBankServices);

  Future<Map<String, dynamic>> getBankAmountItem({
    required String phone,
    required String pin,
    required String offset,
    required String code,

    String? productId,
  }) async {
    final purchaseData = await _mobileBankServices.getMobileBankAmountItem(
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
    final response = await _mobileBankServices.getStockProductName(
      phone: phone,
      pin: pin,
      code: code
    );
    return response;
  }

  
}
